Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B4FED7B86
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 08:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2799610E59F;
	Tue, 14 Apr 2026 08:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m+voK7co";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8981E10E59F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 08:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXdZgvYf6A8y0CkQEt92EdAXa5VU+ZfHPeANYwh54tnY3TTUc0p6uHSdrdoHjV4KwX71XhKhy8kber//4y7F6q17mOMbtmtk5MDO4pq1mgHMjTUM6G0oIm8Kcs0BgiXZr2hN1dXH3JOyYivnrU+IPdnL0VC8g1T04enZ9ktuKEBKRU/z0TOGHKlXFeHg6WlIUUGdPHQcAWSlmCAl/2myIZc1PBa1POhhXMQVGOQX4/l+eTx2S68HhXjFofdqOFbAHECgoPb7vegU2f5YrOnhH483iDZ4wW1XkvQ54nvhqwaroFfwDRfmwXPRQujSmgIdRroM96zyX21mb3rHVACWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCSBoKn2FkspUPVtj0P4/QITNem9qjg6/oNdSHxSMhk=;
 b=f0iqCB2uO5a+SnG/kdKjdyDEH8EkuSJA1NVTK/Z08l1wHJ+YoIFAV6sYYLbzcAuNQjpLC5CmOkHC69a8gyBLwb2Qhf513wguVvOsO57cMi6m7K5+CUe9j/sLaSRvhP3u+dyZny/W+UvurtQjLsjm+uxz7TqkMY26KPhVGnmGgX7AC9cZ8BwBKapdQtsU5aDu8kYfSrPprATz8qMKcCcnyicsghHYn4v315M+KF568hg9mLVlh0rFW6XgWgQaVLJKoWst20m1RBWmrGRWxqnqJZuxfSzTDfjd89y/Bup6mR+pKEi33pCRa+z+APVoE1O+/wB4eSTEd9OayZV5wHWTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCSBoKn2FkspUPVtj0P4/QITNem9qjg6/oNdSHxSMhk=;
 b=m+voK7coyOAWoSilh4wQfp+9dwh3GfEcrpTpjMZ7sDxhnqOhpwQFxCDlO8bgVKuadwZivfjjr+qKm0JkDYARfS99XXawyH0QweQHPC0OyWLQ0cqtvCTZ/KQIEmElksRrNHbcKC9EgIA7drPN6VFy/WbdhAWAx/gYGRdp2FnKV20=
Received: from PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 08:04:24 +0000
Received: from PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::7652:6377:db7d:f42f]) by PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::7652:6377:db7d:f42f%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 08:04:24 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes_v12_1: Fix iterator reuse in
 mes_v12_1_test_ring()
Thread-Topic: [PATCH] drm/amdgpu/mes_v12_1: Fix iterator reuse in
 mes_v12_1_test_ring()
Thread-Index: AQHcyOWBmHfa/Fg6q0W/lAERGb9HgbXeOJRQ
Date: Tue, 14 Apr 2026 08:04:24 +0000
Message-ID: <PH8PR12MB6841E88F9B9DC91651BE2908EF252@PH8PR12MB6841.namprd12.prod.outlook.com>
References: <20260410122756.2287428-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260410122756.2287428-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, en-001, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-14T08:03:32.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6841:EE_|CH3PR12MB8879:EE_
x-ms-office365-filtering-correlation-id: 6a7e3451-8560-4bd6-73bc-08de99fc7118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 1XP0amrYu4Dbh+Cm3C/68B9i/yQFonr8vkos1UIYF552Diq2WHcXrEnCLQXXSBk7RgiGD8bGw+ML8JO4S6YFxT1ISQId3//BDn5dTTiWDaEtUo4vnqeE9Xrd+9D5Tv2P0C7nz1AIza00cxMI1w8SoqoPkRP7/+Ti07O0aDLla9J3fDSZt55lrvTmcGxxVpVv7GpZovNLjMzMVkTVf9DwRQBfWf3QFUs+SG2ZQ6rS7U2hUx91Guc86YaZoncClU+SrBVqW0hMW+saikdSuylPechY1uAEf1uajLBSfa3RpvocY5/kR1NcSQ/0HEW0iM2GqsB0pwZ5tRbtTvtPOEUuY6opJfgv1IgRHg+BHWm6p7JJdzbC9y66BxyZROmzhX65PFQ+cUJiNSuiYE3R8EZ4JeaBPqEv+fpHNxrKEUcb3d3qwj4oQR29foQKXaYeQY6C1WHA95Inc3lnI/IGgFGYC/WamTHz/T+DMIj5X6ZgrR5fRfZLzdDN9kO60EjDZWcoRcXWsLb8TN4LTe7gMR1Z97PDNWws55vpD7XuwrNsaKOSFcS4MHaGhCUUyKAHnSjs8dM8Gbky4Cf52b/xPiTBEFgViXYRJ1wNPRrsqHq2nIDHPXB2A7/ZqHvJE9L1GQ1CskxHEt3rQWxIx47gut15VgYwfX0EbXS+DqUCTXMlHxU7pHuPcYetkgXdr5o0FZDQZCa+gv16CXaMMtgnxbrcKhNMmAUH7FvuDT4UyQu57tmqj5O7YzrwPWtWLT+Fhb/sqGfxpxyt8KR5f6g9Pspqkr60TNjpbauhceNA0SEJhTI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnIvaEM3SkJDbktFVURXeW9BS2hjUVA5UDZsWkxIVHR6QUN1OHVZaHZHOU1V?=
 =?utf-8?B?cXF6dUUvQjQwZjRneGl1Mndpc2JzeUZtakJrTjN6Tk9UYWgyZXRmUDJsL0hJ?=
 =?utf-8?B?cG84ZE9NZlJRcnBzNEM1eFhEeDJJWG9qUjBGb3l0V09xQkEvMjlrYVN0TTY4?=
 =?utf-8?B?MDh3KzR1WjRyQkZtSXdBWHh0OVlrdEg3UW5qdW9KbTJxeG9ZcHlTUkpkSEJX?=
 =?utf-8?B?SnZ3QmhSZVMxR2paMlI2N3hTc0JIU3drQldZL3hMU091RDdNZW9EUUhnTHpE?=
 =?utf-8?B?azFQTDQ2bWJTSENMRWI2Vm44clBqcmgvUHdMQzBLaGhudE9BVVRjMHVxVTRP?=
 =?utf-8?B?OXZVbTluUWxneERaZThTVE5ZWUZmeE4xTG9wc0xaNzRKNXpjNDFEZjBVaUdw?=
 =?utf-8?B?ZDd2YldWelRSRE5DQTREbUlBeVFnaFlnYkd1R1RBRnZUYzVXclpYM2tjT1Ar?=
 =?utf-8?B?QXJmNElVY3htZzRxbFlBWUgzbktEVFpTY0d2dlZYZG5FWjB6Q2xlWnhNNHM4?=
 =?utf-8?B?bTRrN1ZYRXJsYTRoemJLZW8ydE4yWHdhZnhpT0NyYThhaDFxdUNYbUFYSSs5?=
 =?utf-8?B?ZFJaeElwUGxHQmo2R0tmekhjR3BualY0QWhURFdDSlczTXdHSXVGRXlqUzFP?=
 =?utf-8?B?bXNrM0FOOVFkTGo4Uy96L2NaUEdHd0dReGFxVmIwVVd2NXN3KzhGa3pVTDZC?=
 =?utf-8?B?VE80Y09PZ05rZ1c2cjI2bHZ2dGJGOGJmVmYxV2RtTWdxcFJLemlIamZ4c0E4?=
 =?utf-8?B?YVF0RlI0RVNubDgzRk53TnQvaE5jenByb0cwVjFyV0lSQTExd3lpbGt0ZkZm?=
 =?utf-8?B?dTBwaFBEUkFDMUJjNGQ1My9PZFFzUFFhWEhRNjg0b2ptczJuSzRXY3pvUldq?=
 =?utf-8?B?VllMV3JvOVAvTkZLVkg2aGcrcnhkV2xZU1ZxT1oxUW1Jek15V3lDNVAxNHJ2?=
 =?utf-8?B?QVl1c2RFZXdWWlR2TytsQ01ZUElDMGZUZDJMTmdZUjJFU3BTRDVQVjNnT2NW?=
 =?utf-8?B?WTRZbzJyQzRYNXlLd2FPOG43V1B5QzR6MEt2cHBUYUVaM0dqWC9YUHhvNnlV?=
 =?utf-8?B?VnJpVWVoOTBJOTF2eGFsREthMy9KRUt5b1ZmaVRFdUdwVWg5NURrYUJGUVJs?=
 =?utf-8?B?Y1JOUjdocHJGb2pDRFNMbnQ2d2xtYmEzdkJ2Y3VHWE5SR0tYU3RWekZRdklm?=
 =?utf-8?B?b09rMVNmcUZpY0toeFR0TzYxbkppNkVBTGhrMkhpL3BUaXlacnBsT3BwcXNE?=
 =?utf-8?B?M2Z3VUVPYzZtZ004bFBIM1Y1WXlob1c2OTdQSGo2dVNoV29ZSHpnczVtV1N3?=
 =?utf-8?B?WE96c1lWY080ZnBYUU14N0ZidzIwdS8wcTVUUGRPbmFwM3NrSytTUnB0RW9R?=
 =?utf-8?B?RXUyMFdXRmdUT2gvam1FYkpWYklMZ2g4dC9aTktldFh3UDU2RUdrQWZmVDEx?=
 =?utf-8?B?Q1ptYk9KZThYMkRXYmNZWEh3NkpSWVZORjhpVjhLZ0F2dXdycW5iRWEvTnhW?=
 =?utf-8?B?K1RWS2NZZ2ZONXA2QzdxdTRtNFFIS0xweXVoa2ZZTVU5RUZOZ0RDSS8yWDZC?=
 =?utf-8?B?MDMwTWZ4cnRhamM4T2dCREx6UGdoZElYQ3QvUFF4RFRvYnZnYTV6dEUxY1Bw?=
 =?utf-8?B?VG9QT0d2SlFwa0l1c1JBYWZWa1JsdDB1ck96VzFQMEd3OTRleDdyaG81U3ZD?=
 =?utf-8?B?S2UyTHpoOENVOXRkcitOOW1NTFBXRlRUUmxwcHg4aU1wa0xSS25DdCtqNzlm?=
 =?utf-8?B?U0wzaUFmcnBpbWkzaEdBeHlNS25KTVhKMzl4dFVwSFN3WTJrTHdCamhhejhN?=
 =?utf-8?B?Y2V3U2dsR25tdENJeUlKZXNtczAvT1JIOWpkQlhTR1ZUa0FncGhyTEN3SGdN?=
 =?utf-8?B?blN0UXV1ZUdSVVNkZnBxcGJaWnBGNU9qL0xJSmNnZDQwYmpha2RNM0hjSyt1?=
 =?utf-8?B?dkQ1TG9xZ2hrcWR2MVo3VDZ3NEJ4dHBmYm1ZSVBKcWM4MlU2NTJYNkRMQmJp?=
 =?utf-8?B?bkFLVDZEcU9zWC92dy85UDBmbDFpZ01uUDJzNEMrOWp5S2FlMlZFc2J0am1R?=
 =?utf-8?B?cThVZklPdytsUzdLMGYxR0pZWkFhVzA3WGJ5YXpQYzd4clFxcnZBclRWR2hY?=
 =?utf-8?B?UDgwOGNyV0h1NEVQTUh5cnRuRmJmL1J5bklreUdPczRlQnQxVm1MRHVqZksw?=
 =?utf-8?B?VXJiVElKZld3cEN0eUN0WmlGSVljdDVqT2VNeXZsQnpKVnpyVWhyQU8xcUtn?=
 =?utf-8?B?M2JXUGg2UmZLTjFrTFBhU1dtUmthNmNnR25WL0xxOUhmK3B2ZUNyeEhjQmda?=
 =?utf-8?Q?D1IBhy6sPR5eGIRI3p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7e3451-8560-4bd6-73bc-08de99fc7118
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:04:24.1162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCGT4GXegqg3TpqBXXMBonuuZAMXgu64DBoFEfUmskmjUb53C5Ixx36rB936wIww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
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
Cg0KUmV2aWV3ZWQtYnk6IEphY2sgWGlhbyA8SmFjay5YaWFvQGFtZC5jb20+DQoNClJlZ2FyZHMs
DQpKYWNrDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0sIFNS
SU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBGcmlkYXksIEFw
cmlsIDEwLCAyMDI2IDg6MjggUE0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktv
ZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5J
VkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBEYW4gQ2FycGVudGVyIDxkYW4u
Y2FycGVudGVyQGxpbmFyby5vcmc+OyBYaWFvLCBKYWNrIDxKYWNrLlhpYW9AYW1kLmNvbT47IFpo
YW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRncHUvbWVzX3YxMl8xOiBGaXggaXRlcmF0b3IgcmV1c2UgaW4gbWVzX3YxMl8xX3Rlc3Rf
cmluZygpDQoNClRoaXMgY29kZSB3YWl0cyBmb3IgdGhlIE1FUyBzZWxmLXRlc3QgdG8gY29tcGxl
dGUgYnkgcmVwZWF0ZWRseSBjaGVja2luZyBhIHJlZ2lzdGVyIG9yIG1lbW9yeSB2YWx1ZSB1bnRp
bCBpdCBiZWNvbWVzIHZhbGlkIG9yIGEgdGltZW91dCBvY2N1cnMuDQpUaGUgZml4IGVuc3VyZXMg
dGhlIHRpbWVvdXQgY291bnRlciB3b3JrcyBjb3JyZWN0bHkgYnkgbm90IHJldXNpbmcgdGhlIHNh
bWUgdmFyaWFibGUgaW5zaWRlIGFub3RoZXIgbG9vcC4NCg0KbWVzX3YxMl8xX3Rlc3RfcmluZygp
IHVzZXMgJ2knIGFzIHRoZSBvdXRlciB0aW1lb3V0IGxvb3AgY291bnRlciwgYnV0IHJldXNlcyB0
aGUgc2FtZSB2YXJpYWJsZSBmb3IgdGhlIGlubmVyIFhDQyBzY2FuIGluIGNvb3BlcmF0aXZlIG1v
ZGUuDQoNClRoaXMgbWFrZXMgdGhlIHRpbWVvdXQgY291bnRlciBhbWJpZ3VvdXMgYW5kIGNhbiBs
ZWFkIHRvIGluY29ycmVjdCB0aW1lb3V0IGhhbmRsaW5nLiBJdCBhbHNvIHRyaWdnZXJzIGEgU21h
dGNoIHdhcm5pbmcgYWJvdXQgcmV1c2luZyB0aGUgb3V0ZXIgbG9vcCBpdGVyYXRvci4NCg0KRml4
IHRoaXMgYnkgaW50cm9kdWNpbmcgYSBzZXBhcmF0ZSBpdGVyYXRvciBmb3IgdGhlIGlubmVyIFhD
QyBsb29wIHNvIHRoYXQgJ2knIGNvbnRpbnVlcyB0byByZXByZXNlbnQgb25seSB0aGUgdGltZW91
dCB3YWl0IGR1cmF0aW9uLg0KDQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzEu
YzoyMDgwIG1lc192MTJfMV90ZXN0X3JpbmcoKQ0Kd2FybjogcmV1c2luZyBvdXRzaWRlIGl0ZXJh
dG9yOiAnaScNCg0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8xLmMNCiAgICAy
MDY5ICAgICAgICAgYXRvbWljNjRfc2V0KChhdG9taWM2NF90ICopd3B0cl9jcHVfYWRkciwgd3B0
cik7DQogICAgMjA3MCAgICAgICAgIFdET09SQkVMTDY0KGRvb3JiZWxsX2lkeCwgd3B0cik7DQog
ICAgMjA3MQ0KICAgIDIwNzIgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+dXNlY190aW1l
b3V0OyBpKyspIHsNCg0KaSBpcyBjb3VudGluZyB1c2VjDQoNCiAgICAyMDczICAgICAgICAgICAg
ICAgICBpZiAocXVldWVfdHlwZSA9PSBBTURHUFVfUklOR19UWVBFX1NETUEpIHsNCiAgICAyMDc0
ICAgICAgICAgICAgICAgICAgICAgICAgIHRtcCA9IGxlMzJfdG9fY3B1KCpjcHVfcHRyKTsNCiAg
ICAyMDc1ICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KICAgIDIwNzYgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKCFhZGV2LT5tZXMuZW5hYmxlX2Nvb3BfbW9kZSkgew0KICAgIDIwNzcgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0bXAgPSBSUkVHMzJfU09DMTUoR0MsIEdFVF9J
TlNUKEdDLCB4Y2NfaWQpLA0KICAgIDIwNzggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnU0NSQVRDSF9SRUcwKTsNCiAgICAyMDc5ICAgICAgICAg
ICAgICAgICAgICAgICAgIH0gZWxzZSB7DQotLT4gMjA4MCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBudW1feGNjOyBpKyspIHsNCg0KYW5kIHRoZW4gcmUt
dXNlZCB0byBjb3VudCBzb21ldGhpbmcgZWxzZQ0KDQpGaXhlczogNWJhODdjM2U5ZTRiICgiZHJt
L2FtZGdwdS9tZXNfdjEyXzE6IGFkZCBtZXMgc2VsZiB0ZXN0IikNClJlcG9ydGVkLWJ5OiBEYW4g
Q2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQpDYzogSmFjayBYaWFvIDxKYWNr
LlhpYW9AYW1kLmNvbT4NCkNjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
DQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNy
aW5pdmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8xLmMgfCA4ICsrKystLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8xLmMNCmluZGV4IDBlOTA4OTU0NDc2OS4uY2VjODAxMjc4
MTI2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8xLmMN
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMS5jDQpAQCAtMjAyOCw3
ICsyMDI4LDcgQEAgc3RhdGljIGludCBtZXNfdjEyXzFfdGVzdF9yaW5nKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCBpbnQgeGNjX2lkLA0KICAgICAgICBpbnQgbnVtX3hjYyA9IE5VTV9YQ0Mo
YWRldi0+Z2Z4LnhjY19tYXNrKTsNCiAgICAgICAgaW50IHNkbWFfcmluZ19hbGlnbiA9IDB4MTAs
IGNvbXB1dGVfcmluZ19hbGlnbiA9IDB4MTAwOw0KICAgICAgICB1aW50MzJfdCB0bXAsIHhjY19v
ZmZzZXQ7DQotICAgICAgIGludCByID0gMCwgaSwgd3B0ciA9IDA7DQorICAgICAgIGludCByID0g
MCwgaSwgaiwgd3B0ciA9IDA7DQoNCiAgICAgICAgaWYgKHF1ZXVlX3R5cGUgPT0gQU1ER1BVX1JJ
TkdfVFlQRV9DT01QVVRFKSB7DQogICAgICAgICAgICAgICAgaWYgKCFhZGV2LT5tZXMuZW5hYmxl
X2Nvb3BfbW9kZSkgew0KQEAgLTIwNzcsMTEgKzIwNzcsMTEgQEAgc3RhdGljIGludCBtZXNfdjEy
XzFfdGVzdF9yaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgeGNjX2lkLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0bXAgPSBSUkVHMzJfU09DMTUoR0MsIEdFVF9J
TlNUKEdDLCB4Y2NfaWQpLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmVnU0NSQVRDSF9SRUcwKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIH0g
ZWxzZSB7DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBu
dW1feGNjOyBpKyspIHsNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoeGNjX2lkICE9IGFkZXYtPm1lcy5tYXN0ZXJfeGNjX2lkc1tpXSkNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZm9yIChqID0gMDsgaiA8IG51bV94Y2M7IGorKykgew0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh4Y2NfaWQgIT0gYWRldi0+bWVz
Lm1hc3Rlcl94Y2NfaWRzW2pdKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29udGludWU7DQoNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB0bXAgPSBSUkVHMzJfU09DMTUoR0MsIEdFVF9JTlNUKEdDLCBpKSwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0bXAgPSBSUkVHMzJfU09DMTUoR0MsIEdF
VF9JTlNUKEdDLCBqKSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVnU0NSQVRDSF9SRUcwKTsNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAodG1wICE9IDB4REVBREJFRUYpDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCi0tDQoyLjM0LjENCg0K
