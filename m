Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DE0C2A09B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 03:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A9E10EC80;
	Wed,  5 Aug 2026 03:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BS3kc2iZ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB6210E111
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 03:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwMDI4/amMMJKpUmqSnyRmXafrRl9GoXPq59U51CQpTQrVl7DypbYvlGyQI6Ss1i/nAdfOw5kdASt7kP9mlc0KY/Tduj0ZpviEDnKdCit09kTZ6RAnTjiYnrgwJad5I2QMMM2DvXYh+zmdE0V57KAD3v9Jv5mOmr/WD7b6F+uKT8xTFyo1tvnMTiHCskkbPcGFTF06QqSHkeL6pIT7pXjGhGP2jCiwWzjd2gYIoa3JkZKBC17gEJOu8Lu9AvPSdtEzbq3Wf2Dl0uBu6jBwMGmZQ+Gi7VSuE85z/p0+85nF2RB86uNnMMwbYCmDgSZrDD8k8JGoqPmiJQiQpwTDcG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etnUppWtir17YKiiXoq6rSD3LywOsyWkpE+5YwK7BoU=;
 b=j++tEQOSBgGZ5A9Ndouj+JnRBe+pllFLGhkFn2DxDfpPTqCblKWyOQ41k77sT0cDA/qO9txmnz66oesArFFOXzcMyfI5ODOLcXJGczG2wXV3tV/pDSztEoen3Gb7exY0RnqazMNlqD7/bhQmWqXI+TA/YnWjQdwmShUNw3cCArD6ngwJXBQG1ERNi/KfU3yPmipSMCN0clhakibuXV9cnNn07kgEyX1HwpbPctAYlt93Qbi6ZLy/AqSeALxcR3ycSXY4WmlaYmCbIaJrHuRcZ94VLqVMFJnOMwxulHUqhILPozjT0gnaghqqcjmeay4EG7Ow6FdZPy3E+Vszc7E5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etnUppWtir17YKiiXoq6rSD3LywOsyWkpE+5YwK7BoU=;
 b=BS3kc2iZd6zenkeCGMe97ekPOmMUml0mNRIrzqF6WQwqx9OzXNpevHID4jYsJ8tJnaqgDZTG8ly2wRth+yiutwCHDAPqVGU3QzPdnHaA/H0u7O2ePwxR7/enQEHALooUhKi8DSbvmGC66eyGABytymdYcgT6oiwKtp+9YUbvexQ=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 03:00:11 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 03:00:11 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
Thread-Index: AQHdHaPl+GPUDG9IJ0eDg5noP1xcN7aN9yAAgADaH5A=
Date: Wed, 5 Aug 2026 03:00:11 +0000
Message-ID: <DM4PR12MB5152FFAFB3DCD06996A45988E3D32@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260727084238.3396808-1-Jesse.Zhang@amd.com>
 <84e4330b-1ea5-4499-a9a8-672f2a12c70f@amd.com>
In-Reply-To: <84e4330b-1ea5-4499-a9a8-672f2a12c70f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-05T02:58:17.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY3PR12MB9577:EE_
x-ms-office365-filtering-correlation-id: 271b800f-b7fe-4797-9db1-08def29daa31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|56012099006|10067099003|11063799006|4143699003|22082099003|3023799007|18002099003;
x-microsoft-antispam-message-info: dhGjbYYWXf+Nk6/8v0BOu6ee8nHA8IqvbRAht6tRmMPBsImvufGQutGrKVnVv9evcaOFK9MlroAns4fbt/i3DLluuJjP9Via9V46H6O6RqegKBP3QMV4D1VEamymiGZovxsUj/GVZO0qKvPYSp/EtqOLY0oiGSzJ2wurIaTuiT3gGSGUrx2p7CZn14ttWnJlzy1dvKfZXHfjxamHbmU0+DUbdZ4+tjY9gkW1VDo93GW3kFDPCHD0sC29AmwDJsvXrnYZblwBUDujLznu59lJJa+Npmj/B4L52X2KGkQwOPJIbndu5Cs8BjJi+fYo5xHiGgwUfQEoc7xCe9XGb29Q2QYekYxbe3FcvfYI10TT8hzsSWeFb+xOw0N7Uy9iQi88Nh2Gujb9Ly8RA6Y9e+HwrpqF+JJ0cIiwfmSh4QhB1ORS2JBg3MS1b8iBKJ6St7Wyeom+5ECluw/1OfT+3MAUH/fXqejQrHvS/emcxWCbwucfZPlyzv2SRyrMcpa+q88HMrtp3SF6FLpdcDPDqaXE6scYlSIgegZ4XWavWvTwraSmfuYLQQgL3ON7D8iJMe+ghJPj6VWvMdYIM4WkkB9ZlA9NzlzHgD+iDteL08AVDRGmGdik5CNe9kniWgnt1PN3/d32GEJVdJKuuOmq8II9Fg5G2xVe0bmVhaOC8faewf06uwID4xhPsmun4uP1GqQ5HkKsPnGQnqI2Xqbw6uzIPqxVMECjAAgIyxnpr/PZGSc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T240LzNlL3ZYbERHbW9SeW5yQ0psM0tQckpkZlhua2lnNzdPZU0xV2gxQXh5?=
 =?utf-8?B?bHpwSUdyYk5GVzc0b2Z0WUpkZzVjYmkwSlBHUHgwTWY2QSsxaEhOTEVNZURU?=
 =?utf-8?B?T2wxdDZtSjI4emJPYkk2YTNFQzRFY3dNL1ZwUUlzK2IrVkRXNHhkMkY2N0Vx?=
 =?utf-8?B?aEkyVlNDcU1UWjZpRnhNOURKT2hkTjBiVno5di9oMzV2R3B5b1B1Tm1OTmZC?=
 =?utf-8?B?bFZ0MHdKU1dIVGhjU1RnVUtpU0lwd3RoTWdjMWo0QmNqZWlOWm5XaGd3bmJM?=
 =?utf-8?B?cG45UE8yNTRseHRjWXhmYndJMEkwMitvOFpTakYrSGpDb1ZFdmRzQ0JSVUM4?=
 =?utf-8?B?RVdXL3l3emk3NC9XMFd6NmtOa2cvbXBUTk1vUW5QL3NNSitrdFhhWFViK1pZ?=
 =?utf-8?B?aWtDK1BlNFpaYS9Dck9weW9jSzQvcVBXYUVrT1Fkdk9Bd0hKK2tjcVI1aUpO?=
 =?utf-8?B?QVNoV0dtWUZob25vL2hldS9OK3JxUDFkZkFOVkpnaFZoY3ZMN0xXTXk4Qzdv?=
 =?utf-8?B?M0NGeFF0NVFNZmJzY1lKN3ByN05VYThzRkdXTmpMd0xlUFZZUE56V3gzcERC?=
 =?utf-8?B?ZDFpSGU1aDFDNENPQXR6R0JvT2dvYWozOHNncUF5Q0pBNW9oTWlUUUJjK2ha?=
 =?utf-8?B?QkZDeXR1NUVZcUllWktvNHlKWTJmVUZwakwrZ2pHazB6VjFzcDFsVWZZcjlR?=
 =?utf-8?B?MXhBdUJhTC9Da3R6TnBGVkNlS0d6YUE4bVBLVlBtdzhISHpqK2pNZm5Zaitv?=
 =?utf-8?B?aWgzcm1yeFE2Y2kzU0ZPcGJvZ2pxOU5kRytVamNhb09zR2FvWUtYOXhJRVd0?=
 =?utf-8?B?ZzRvNVRLU3g0cWxVK0crN0pVVHh2Ump6VHRjR1MzNnRkRDN1R3RncU9JajJh?=
 =?utf-8?B?QzNHRWdxNU1PYzJoYTVYWkZ3VXVqNDFQNHRZY3FObGdZcXlBeWpFMXIrMUN2?=
 =?utf-8?B?V3JrMm9FbU03NG9GamwwRjE1QS94UHZvR2xpRnRMOHFFZ2UvYklCQzFRYldt?=
 =?utf-8?B?WE91TDF1M05WUktLUzFNbzJTMFRabUJ4SUZSbVloRk9zQ2RvbU9NQ0tWSGJI?=
 =?utf-8?B?NzVXZHVCbE1MaVkzbS9ib3RNVlZ5bEErUTJNTjhaYjhUWjRhYkxMRHlvdU5r?=
 =?utf-8?B?OTlONmNzZEdrdkxkOXM0SUpFWEkzb1o4UEZqT3NEMDhpeUZHVkxFY21SdVNM?=
 =?utf-8?B?WXU4NWFmL0Fic1kvVGJrUThwZThCWk9NMVlXZUFrU0NNcHBXTGxhWHJIYjJG?=
 =?utf-8?B?SVhEejkvTXk0YzRxZ3BoUTFuY1hZQVRLajBhYmJnNDYybDg3QkkxVW4wM25Z?=
 =?utf-8?B?RjQ2cGFXa09sSWdONkkwR0IvUUFqRXNTUWM1WCswM1JxdTB2bGlJeDJobjN4?=
 =?utf-8?B?ekVnVzhPNkowS2s5NGYrUTJkQ3ZVV3dHeFFYN1Y5UHVPYWdmb1NYaDJvck1W?=
 =?utf-8?B?VW44NGdGV2h5ZUJodHlYSnViWnYza09OZGkvUHNTSlUyanJxckNiaFJ6RmpG?=
 =?utf-8?B?SGg1Z2tIbkFBTGZuRDMyTURmOFptVzIzSWtBTlRRZDZRdDVScndzYzV0THV6?=
 =?utf-8?B?UjR4WUZpcmpVOWorVHZmUEZ2ODZ2SVRWWDBKNHV3K1ZZNVJ4Nm5NcHZMWjVB?=
 =?utf-8?B?Qkl4dEVIT2FCcUNEUXJWSEY5OFgybW9nUWwxeGE0dXpHa1o3ZFpsMEVBWHVp?=
 =?utf-8?B?RG1LbnZXa21yQTQyeVBVYXFVY05hcWNUeW9FVVAxWjBwVHB3djF4U29jVDFl?=
 =?utf-8?B?L3BRVzgrZjEwc05xbU11Z2dNTkRYZWErVXhvUHNPa3RFUm5aamZlcVJXWDY0?=
 =?utf-8?B?Y3lhU3NpOEJ3cHFYNTVkYVcvcHdvQVhldkFEVERBQ1pGSk9na1RDZE1VZm41?=
 =?utf-8?B?dlRzdi9mMnNCMmVYVEVDYlpZMHkxS1NjSDdwQ1RIN1pLZ2VDNU5vS0RORnNy?=
 =?utf-8?B?TnVRMElSQVptcjNhZGp2c0RIOGl1NFhVbUtuZEZ3OGs0RUo4dTZBc0Q2S2Fq?=
 =?utf-8?B?VFgyNFZidzJZRGxjRjZoamZrVkw3bGxlelF5NHVOc3c2RlpHWEFjTDhHMEpn?=
 =?utf-8?B?QlA1b0ZYVkxOOGo2RUhTRkdkM2JsOEtnZG03NmJzRWdkeXozdHBZYjBORmJM?=
 =?utf-8?B?MVBmaWRSYXAxUW9KeUNES0ZDUVdNWU9wZEhjSlIyV01EZVVFOThmK04yZ0Fn?=
 =?utf-8?B?ZmowdjNVUDgxc2FFOGEzN3VnUk9EbUVtdWJmM0xtU25zanhsbkJZNlA0NlZu?=
 =?utf-8?B?U0k1c3RTaS9YUkN6bkcrR2VXakpMeWNZRjVlNmJEWlJvRVByS05jKzgyWjB0?=
 =?utf-8?Q?mg188cPetcB3nbdP2W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271b800f-b7fe-4797-9db1-08def29daa31
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 03:00:11.2146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bc5gCuIcHnweaiGfHe/cUOJ/5MKmDryaPaiflD79Zf3GY7kf89Iqwzd+gnVRWgSlzwljr0iDIag5faqdcIzvew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBBdWd1c3QgNCwgMjAyNiA5OjU4IFBNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2Uu
WmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBOVUxMIHBvaW50ZXIgZGVyZWYgaW4NCj4gYW1kZ3B1
X3ZtX2hhbmRsZV9tb3ZlZCBmb3IgQk8tbGVzcyBtYXBwaW5ncw0KPg0KPiBPbiA3LzI3LzI2IDEw
OjQwLCBKZXNzZSBaaGFuZyB3cm90ZToNCj4gPiBUaGUgaW5kaXZpZHVhbC5uZWVkc191cGRhdGUg
bG9vcCBpbiBhbWRncHVfdm1faGFuZGxlX21vdmVkKCkNCj4gPiB1bmNvbmRpdGlvbmFsbHkgZGVy
ZWZlcmVuY2VkIGJvX3ZhLT5iYXNlLmJvICh0byByZWFkIGl0cyByZXNlcnZhdGlvbg0KPiA+IG9i
amVjdCwgdHRtX3R0IGFuZCB0byB0ZXN0IGZvciBhIERNQUJ1ZiBpbXBvcnQpLiBIb3dldmVyDQo+
ID4gYm9fdmEtPmJhc2UuYm8gY2FuIGxlZ2l0aW1hdGVseSBiZSBOVUxMIGZvciBQUlQvc3BhcnNl
IG1hcHBpbmdzIC0NCj4gPiBhbWRncHVfdm1fYm9fdXBkYXRlKCkgYWxyZWFkeSBoYW5kbGVzIGEg
TlVMTCBibyB2aWEgaXRzICJlbHNlIGlmDQo+ID4gKCFibykiIFBSVCBwYXRoLiBXaGVuIHN1Y2gg
YSBib192YSByZWFjaGVzIHRoZSBtb3ZlZCBsaXN0IChlLmcuIHRoZQ0KPiA+IHVzZXJxIGV2aWN0
aW9uIHJlc3RvcmUgd29ya2VyIHJ1bm5pbmcgYW1kZ3B1X3ZtX2hhbmRsZV9tb3ZlZCgpIHdoaWxl
IGEgdXNlcg0KPiBxdWV1ZSBpcyBiZWluZyB0b3JuIGRvd24gZHVyaW5nIGEgR1BVIHJlc2V0KSwg
dGhlIE5VTEwgZGVyZWYgY3Jhc2hlcyB0aGUga2VybmVsOg0KPiA+DQo+ID4gICBCVUc6IGtlcm5l
bCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAwMDAwMDAwMDAwMDAxNTgNCj4g
PiAgICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPiA+ICAgT29w
czogMDAwMCBbIzFdIFNNUCBOT1BUSQ0KPiA+ICAgV29ya3F1ZXVlOiBldmVudHMgYW1kZ3B1X3Vz
ZXJxX3Jlc3RvcmVfd29ya2VyIFthbWRncHVdDQo+ID4gICBSSVA6IDAwMTA6YW1kZ3B1X3ZtX2hh
bmRsZV9tb3ZlZCsweDE3YS8weDIwMCBbYW1kZ3B1XQ0KPiA+ICAgQ2FsbCBUcmFjZToNCj4gPiAg
ICA8VEFTSz4NCj4gPiAgICBhbWRncHVfdXNlcnFfdm1fdmFsaWRhdGVfYW5kX3Jlc3RvcmVfcXVl
dWUrMHgyY2UvMHg5MjAgW2FtZGdwdV0NCj4gPiAgICBhbWRncHVfdXNlcnFfcmVzdG9yZV93b3Jr
ZXIrMHhjZS8weDIxMCBbYW1kZ3B1XQ0KPiA+ICAgIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4
YTYvMHg0NjANCj4gPiAgICB3b3JrZXJfdGhyZWFkKzB4MTNjLzB4MjkwDQo+ID4gICAga3RocmVh
ZCsweGZiLzB4MTQwDQo+ID4gICAgcmV0X2Zyb21fZm9yaysweDFiNi8weDJiMA0KPiA+ICAgIHJl
dF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPiA+ICAgIDwvVEFTSz4NCj4gPg0KPiA+IFRoZSBm
YXVsdGluZyBpbnN0cnVjdGlvbiBpcyAibW92IHJheCxbcmR4KzB4MTU4XSIgd2l0aCByZHggKGJv
KSA9PSAwDQo+ID4gYW5kDQo+ID4gQ1IyID09IDB4MTU4LCBpLmUuIHJlYWRpbmcgYm8tPnRiby5i
YXNlLnJlc3Ygb2ZmIGEgTlVMTCBiby4NCj4gPg0KPiA+IEd1YXJkIHRoZSBCTy1sZXNzIGNhc2U6
IHNraXAgdGhlIHJlc2VydmF0aW9uIGRhbmNlIGFuZCB0aGUNCj4gPiBETUFCdWYtaW1wb3J0IGNo
ZWNrIHdoZW4gYm8gaXMgTlVMTCwgYW5kIGxldCBhbWRncHVfdm1fYm9fdXBkYXRlKCkgdGFrZQ0K
PiBpdHMgZXhpc3RpbmcgUFJUIHBhdGguDQo+DQo+IENsZWFyIE5BSy4gUFJUIG1hcHBpbmdzIHNo
b3VsZCAqbmV2ZXIqIGJlIG9uIHRoZSBtb3ZlZCBsaXN0IGluIHRoZSBmaXJzdCBwbGFjZS4NClRo
YW5rcyBmb3IgdGhlIHJldmlldy4NCkkgdHJhY2tlZCB0aGUgaXNzdWUgdG8gdGhlIHN0YXRlLW1h
Y2hpbmUgcGF0aDogYW1kZ3B1X3ZtX2JvX3VwZGF0ZSgpIGNhbiBwdXQgYQ0KTlVMTC1ibyBib192
YSBvbnRvIGluZGl2aWR1YWwuaWRsZSB2aWEgYW1kZ3B1X3ZtX2JvX2lkbGUoKSwgYW5kIHRoZW4N
CmFtZGdwdV92bV9ib19yZXNldF9zdGF0ZV9tYWNoaW5lKCkgcHJvbW90ZXMgaXQgdG8gaW5kaXZp
ZHVhbC5uZWVkc191cGRhdGUgYWZ0ZXIgYSBWTSBnZW5lcmF0aW9uIHJlc2V0Lg0KDQpJ4oCZbGwg
c2VuZCB2MiB0aGF0IGZpeGVzIHRoaXMgYXQgdGhlIHByb2R1Y2VyIHNpZGUgYnkga2VlcGluZyBO
VUxMLWJvIChQUlQpDQptYXBwaW5ncyBvZmYgdGhlIHZtX2JvIHN0YXRlIGxpc3RzLCBhbmQgSeKA
mWxsIGRyb3AgdGhlIGNvbnN1bWVyLXNpZGUgTlVMTCBndWFyZA0KZnJvbSB2MS4NCg0KVGhhbmtz
LA0KSmVzc2UNCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTIgKysrKysrKysrLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gaW5k
ZXggYWFjOGFjZTlkN2E2Li5mYmI3NmMzMmJmZjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiA+IEBAIC0xNjMxLDExICsxNjMxLDE3IEBAIGludCBh
bWRncHVfdm1faGFuZGxlX21vdmVkKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+
ICAgICAgICAgICAgIGJvX3ZhID0gbGlzdF9maXJzdF9lbnRyeSgmdm0tPmluZGl2aWR1YWwubmVl
ZHNfdXBkYXRlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0eXBl
b2YoKmJvX3ZhKSwgYmFzZS52bV9zdGF0dXMpOw0KPiA+ICAgICAgICAgICAgIGJvID0gYm9fdmEt
PmJhc2UuYm87DQo+ID4gLSAgICAgICAgICAgcmVzdiA9IGJvLT50Ym8uYmFzZS5yZXN2Ow0KPiA+
ICsgICAgICAgICAgIHJlc3YgPSBibyA/IGJvLT50Ym8uYmFzZS5yZXN2IDogTlVMTDsNCj4gPiAg
ICAgICAgICAgICBzcGluX3VubG9jaygmdm0tPmluZGl2aWR1YWxfbG9jayk7DQo+ID4NCj4gPiAr
ICAgICAgICAgICAvKiBQUlQvc3BhcnNlIG1hcHBpbmdzIGhhdmUgbm8gQk8gdG8gcmVzZXJ2ZTsg
anVzdCB1cGRhdGUgdGhlDQo+ID4gKyAgICAgICAgICAgICogcGFnZSB0YWJsZXMgKGFtZGdwdV92
bV9ib191cGRhdGUoKSBoYW5kbGVzIGEgTlVMTCBibykuDQo+ID4gKyAgICAgICAgICAgICovDQo+
ID4gKyAgICAgICAgICAgaWYgKCFibykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgY2xlYXIg
PSBmYWxzZTsNCj4gPiArICAgICAgICAgICAgICAgICAgIHVubG9jayA9IGZhbHNlOw0KPiA+ICAg
ICAgICAgICAgIC8qIFRyeSB0byByZXNlcnZlIHRoZSBCTyB0byBhdm9pZCBjbGVhcmluZyBpdHMg
cHRlcyAqLw0KPiA+IC0gICAgICAgICAgIGlmICghYWRldi0+ZGVidWdfdm0gJiYgIWFtZGdwdV90
dG1fdHRfZ2V0X3VzZXJtbShiby0+dGJvLnR0bSkNCj4gJiYNCj4gPiArICAgICAgICAgICB9IGVs
c2UgaWYgKCFhZGV2LT5kZWJ1Z192bSAmJg0KPiA+ICshYW1kZ3B1X3R0bV90dF9nZXRfdXNlcm1t
KGJvLT50Ym8udHRtKSAmJg0KPiA+ICAgICAgICAgICAgICAgICBkbWFfcmVzdl90cnlsb2NrKHJl
c3YpKSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICBjbGVhciA9IGZhbHNlOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgdW5sb2NrID0gdHJ1ZTsNCj4gPiBAQCAtMTY1OSw3ICsxNjY1LDcgQEAg
aW50IGFtZGdwdV92bV9oYW5kbGVfbW92ZWQoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYs
DQo+ID4gICAgICAgICAgICAgLyogUmVtZW1iZXIgZXZpY3RlZCBETUFCdWYgaW1wb3J0cyBpbiBj
b21wdXRlIFZNcyBmb3IgbGF0ZXINCj4gPiAgICAgICAgICAgICAgKiB2YWxpZGF0aW9uDQo+ID4g
ICAgICAgICAgICAgICovDQo+ID4gLSAgICAgICAgICAgaWYgKHZtLT5pc19jb21wdXRlX2NvbnRl
eHQgJiYNCj4gPiArICAgICAgICAgICBpZiAoYm8gJiYgdm0tPmlzX2NvbXB1dGVfY29udGV4dCAm
Jg0KPiA+ICAgICAgICAgICAgICAgICBkcm1fZ2VtX2lzX2ltcG9ydGVkKCZib192YS0+YmFzZS5i
by0+dGJvLmJhc2UpICYmDQo+ID4gICAgICAgICAgICAgICAgICghYm9fdmEtPmJhc2UuYm8tPnRi
by5yZXNvdXJjZSB8fA0KPiA+ICAgICAgICAgICAgICAgICAgYm9fdmEtPmJhc2UuYm8tPnRiby5y
ZXNvdXJjZS0+bWVtX3R5cGUgPT0NCj4gVFRNX1BMX1NZU1RFTSkpDQoNCg==
