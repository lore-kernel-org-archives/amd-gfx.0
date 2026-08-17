Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A40C5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 06:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0FD10E3D4;
	Mon, 17 Aug 2026 06:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bqukLfhI";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013068.outbound.protection.outlook.com
 [40.93.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E6B10E3D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 06:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZolwgDp9OeFk+iQ6qDLm2/P3J33sg+ZkxdEmcyLOX5+/wH+f85jqFu8A407JEg6ZxU9fiiHqRLu5fTvT9dhLY1CaTEdfJ5HvFmfy/Y53/ANPSyqDlJNqIEBsllDqXGhJC77HPqjfzkBlePDCwwp1zR9kbA8ClJAd7qhveg2uLbJxtmYtv8AdismatF00q9O1wvhTPmVMH1Xx+J9P5kexkfAgBS7+ocExyJb3O6dv1RxO6Y521Vlzx9lI7s2P0ucu2MxPnRVDTURuZrtlJX1ThM6FxFQmG7YDEtBRQenu9GfmVMcytijkV0NYT84gqgkHG82a5O8cSuDfMrjE14OXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pi2WO5SiwQ7446BhpG9pbVPh1gQ09ybLA97Q3HWknMg=;
 b=qNlEcupNrCujqOhTXUmYhXTNWF8WjXl62oxrbQINHnNjoY2Xx2+8+Pi/7ZJWEyZYt+zzGjzl2AKxQMAjsws/zTxVynNeDJqCt+LKo70mysRyNjFZX7k+gIeNXEvUD28mG9VDKUXeYxrj4gNy+5fWCgOD0VpEaq3m1+PB5/lW30EHGJppoNIqzmE4wMpnho2eYa31SeprEXFNTn/A/COxKLCvLexPCtK/MPHth8WWm0rMnX011bFdsDUH7eZnbKiS2+BpdbzFV6UbqKUo616EngHYRBRM2w2fkA8lgWWyHc2NLJa73iJ5xZVKUl5jjajMwIDM93deI3T1WhEVq7OKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi2WO5SiwQ7446BhpG9pbVPh1gQ09ybLA97Q3HWknMg=;
 b=bqukLfhICDcsSlV42mw81PgU6PP1yd8q7cmgqGv9Go1PfaSA+w3pqWnXF8+Y5SGHArfUJ7ZSR2KlwoAMhmVo7zOK3WRKZ/llTGCKCp9H6FWO7IaCC9WzHdfPjgSYW7Ouht6yRkQ6L8vSzwxEDos97bFNzXVNu9Zq9N29GRbDjd4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:44:14 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:44:14 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: lock and validate wptr BOs before
 reading their GPU offset on restore
Thread-Topic: [PATCH] drm/amdgpu/userq: lock and validate wptr BOs before
 reading their GPU offset on restore
Thread-Index: AQHdK8rQ2qk7rFxkFkCTh7z8nTk1GLadaN+AgARm0EA=
Date: Mon, 17 Aug 2026 06:44:13 +0000
Message-ID: <DM4PR12MB5152C57D2F4785EFCD1048AAE3A72@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260814085626.80716-1-Jesse.Zhang@amd.com>
 <ec751f5b-e6bb-4c1d-93dd-f9d4418ab70f@amd.com>
In-Reply-To: <ec751f5b-e6bb-4c1d-93dd-f9d4418ab70f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-17T06:42:55.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH3PR12MB8212:EE_
x-ms-office365-filtering-correlation-id: 7351c689-5e90-4488-22ec-08defc2af3a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: eG/1XYoZ4pyrn/JL9vziAXtm+MkplWs8s4n2UX58zOr/7FwvasKRdD4PyfgqFBmvRb0jYyOejOfkPsN2G0lAkhNsanRSD9Iqy0pY1rJmwTgTH789AEIEaOZzI1iEpdRC7I12vCTvlRBRXIV3+CNFTrglcF+qBnVSjoikdFOEp2qWvWEQaPWi8N27pUab/ZeBU2lN/7C/5yTbyO7ynhx+8jRbYYjAOS2sDKFCuquppqMKc0SxgGC87c0sERXI705vDfKnJOng/D5hGeE2qJXVGpvh3D1rqyvDBja5KY03vVCJ+ILJE82kjJ2kRcolX2YQnK+dqgKPCXQ3H3BQF2fo+K4GgySErUtri4AypwOAmBFtmALNVQ6VL3vHL++5/3dyfWUtipBMrkB3D95uGuhczrIBUgY7uT0rIxxNXDUKNvAu+9vKKyxrM+kNSLZg8+q/QYl0oHuJK0q3pK002IVwwTRGdoDfj4efm4mCPveO6WU2G/X3L+lS9PSsjnvJP7ba9xfnLTAJQzBfsX4yJbxmJcDa1FLGRrJ5yzme3pz8k3ZHMrck5f7ox75f2x7VNP4+n1oWBXVSJ8jFvjIiLM8EXM3rbvbyjrke9vCz3+AkXX3vIndDgtEhmEyL9elcXmJnKaqSN6XezytCgCFkfSEtkLyrpotjOvvP5muAOnDPeR4f+RnyQbaJfybvkjqeScRL74oeyzMUrTl0hV7mczU44tiUDbh76wOS+hFtPI+aXnY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU83WWlzRytxOVhNT25SS2dmeCtGV0s4NXgvQWduTnV0dUtKNGIxb29ETDZO?=
 =?utf-8?B?aGk2dFFWazNXNUFsTzRpaTFYZ0orcU5BN3RyWFBNdVRKSnNVTmM1bVdHbFZS?=
 =?utf-8?B?RlZuVkxnUDU4eGQ2US9lWmdVOXBjQlB1cnZ3UkVvZU1KQ3hKTEg4b214WmlK?=
 =?utf-8?B?TnZkb05JTnlTc1U2RjVNVnBOWHRaTVVuS1ZhU0tPOFlTS0IxVVovRmRnMndl?=
 =?utf-8?B?clpzYklTck56Mm5BWUJScFZMenBFbkRtNGVPaXloMGlQd2NXdUFBY2FlblJK?=
 =?utf-8?B?MzQrK3dpZjkwRU9tN2VTTlk0d0VUSC81azJ2T2pkb0lTZDB6TmZqdmZoWE9a?=
 =?utf-8?B?VzZjOTRWbHpoY0ZoUW10ZHNPSEhFRU0rUXlMbUluM1hKR3pObVFQeHBoYU03?=
 =?utf-8?B?Z3ZlRFdBekZsdTFNdVlMZU8zTGdDNDVHbW41VlJOclpHVkx4c1FGOWVDdFZi?=
 =?utf-8?B?emR1MitvQXBCdkFEZ3VUNi9ZdmNyRjFkS2xENXNSWHJaSkloa2Z1QkRXcm0y?=
 =?utf-8?B?TGpWN1pxbS83aU5IVGVwcE9xZ1VFKzNhMFA4d1IvdGRTa0xyTE0yL2xMV0tH?=
 =?utf-8?B?dGFDQlNZaHZDR2pjc0RrZy8xVXdkc0pXU05WUTFOdUdXSkpEamJjMWwzSmt5?=
 =?utf-8?B?aGY2bVVwbDRjMGhoY0NqU3RvZk5FaUFqalhmb2ljWG1hTU5MUGNSeEdzdVNx?=
 =?utf-8?B?VEE0NWpBWnFocW9tb1A4bHNHaXc1WWh0a3NaTnRKaWc4NGJhak9JWXVvN1ZM?=
 =?utf-8?B?aEJ5dk5UUm82d0g0QktDbFQwQzJodmtDY1BxQXFkNnMwMDRPc0UyWkttc3l6?=
 =?utf-8?B?L2ZRRkRBSCthaUpLWWxRVnk5S1hDT3d2dFowblZhc3FCaUU2YWFyY0t6dlJn?=
 =?utf-8?B?RTF1cU1jSE1iZm9pcjRsa3g0Y1FRWDczMURsSGM2QitJUmR2aDdDdllGK01B?=
 =?utf-8?B?Z0t1WEdWYjJGdjRmTHlFU0k1ZmxVdkI5VnRoNVFNb0x4TWE1b2NPMzNXb3hZ?=
 =?utf-8?B?R0tYbk5UMjJOOGMxSk9xbDFoNGJuZlpsVkpUQ2RsR202M2pJdG1aUXBjczVi?=
 =?utf-8?B?alNiaHVBd2dyaE5iUlA0bXd6V2pCMlZBMnh2aVpvSy9CYnRyU2c1a09PUzR0?=
 =?utf-8?B?ellSUVNJZzZPdUNsZWJZVXhOcDhDTnIzNW54b2VKOFdpMVBOZm8vS1Z0T3ZI?=
 =?utf-8?B?WGMxakhkSjliUUFrajQrZEhNbjB3UUhWcXkyd3NBUVZPemFsSWJ1QTV0ZE5U?=
 =?utf-8?B?RkVLQzM2V0l1K3dyeWRrTjZsVDhoL3Bsc1pXVUljR3lkTjNxTXl0dTlFL1E0?=
 =?utf-8?B?RisxWTliMmJhaXFsNWlsT2xxRm5TMW5GQU9pbDNOQVk4UUhrbm1VTGpmck94?=
 =?utf-8?B?WGh6ZmZvU2pmMThDVDAwL2lCZnkrSEYwZmdqaFkzNE0rR3JMM2ljeFArYnp5?=
 =?utf-8?B?NU04Ky9VTDlQc2JVT2hSZklyYUc4NVhQZlhCblIwRE5NU1QxeE9jL0RleSsx?=
 =?utf-8?B?L2YwemUvVVRRZGI1MHBqTGhqSGhxcFp1cnIwR3lZa0Y2VWVkejRzVkRrSXdj?=
 =?utf-8?B?OVlwRnhlK3d1TDlVT2IrRXdORHIxVk0yYklOS2VYMjlqcWl3eEhIUkRtVmdX?=
 =?utf-8?B?YnBJdlpna0VqVWtZa2MzMFpBNTlzVTBacmJXVEQ4U1NwVE1ORjJvUExPVVdl?=
 =?utf-8?B?cUs2Rlc3S3dIMVZPeWJuUlVwOUVzWXE3KzRFUEJQUjdzVzVmQlJLb3BRWENJ?=
 =?utf-8?B?Z0hqOW5BTUorQTZJcURmeFd1enJkZmpZYTR6Wmw5QXMzNFpRcGs1Vm55RW5O?=
 =?utf-8?B?UHBJdmtOZFllQ0ExOXNWV0xWeDhoZDhQeFovVXlLQnpObDVKcUQ5Qm0xK3pt?=
 =?utf-8?B?Y0gra0Mzc2RnNnB2OGpZek9tNXpJN2FXbitENi9XNFJQRVdqL3hRNzlobWdW?=
 =?utf-8?B?elhvemZxYjlBeFRoZFRHMW0xd2FwbW5zdnNHTFdXYXdsTml2T0tkZ1NGS1pM?=
 =?utf-8?B?OXpTeHRZTWJ6aTFQV1ZyQ2tpNWMrdzdzeGxMeEhpbEg2MGY4RXlqc2p0WUJk?=
 =?utf-8?B?N2VsSjJPZUpGYmd1ekgrZy9SRzBKeG9MUUU5UFhJek91VE5FRGlNZXFHY0ZX?=
 =?utf-8?B?ZzNjKzRJb1VSUllwOFAzWjNUekVqb2R1bGpJcGwzbDI3Y1V5RnNhQ2ZCbHhM?=
 =?utf-8?B?WnR1TkdLbDNMMGN1dTQ2Y2pGdStUd3RiVSs0dzJsUmxGRTZBNmtjM0x0THNT?=
 =?utf-8?B?K0s1dXRGak5rQ3pFQURTUkdscXg1OTg2SEJuVHNNemk1QXlCMGtiaUw3V2dX?=
 =?utf-8?Q?QVU9u1OXglv+2GTjuJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7351c689-5e90-4488-22ec-08defc2af3a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 06:44:13.8937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8PjpoMa5FfdZ3eooyhnGmd8IR18XEwgfi6ijbFW3VhFzfZd0QoeEwVhdDI9tFqZhLBHpFIVeHSk+xRekZjoag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXks
IEF1Z3VzdCAxNCwgMjAyNiA3OjMwIFBNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2Uu
WmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaWFuZywgUHJpa2UN
Cj4gPFByaWtlLkxpYW5nQGFtZC5jb20+OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS91c2VycTogbG9jayBhbmQg
dmFsaWRhdGUgd3B0ciBCT3MgYmVmb3JlDQo+IHJlYWRpbmcgdGhlaXIgR1BVIG9mZnNldCBvbiBy
ZXN0b3JlDQo+DQo+DQo+DQo+IE9uIDgvMTQvMjYgMTA6NTUsIEplc3NlIFpoYW5nIHdyb3RlOg0K
PiA+IGFtZGdwdV91c2VycV92bV92YWxpZGF0ZV9hbmRfcmVzdG9yZV9xdWV1ZSgpIHJlYWRzIGVh
Y2ggcXVldWUncyB3cHRyDQo+ID4gQk8gR1BVIG9mZnNldCB2aWEgYW1kZ3B1X2JvX2dwdV9vZmZz
ZXQoKSBhZnRlciBvbmx5IGNhbGxpbmcNCj4gPiBhbWRncHVfdHRtX2FsbG9jX2dhcnQoKSBvbiBp
dC4gQnV0IHRoZSB3cHRyIEJPcyBhcmUgbm90IHBhcnQgb2YgdGhpcw0KPiA+IFZNICh0aGVpciBy
ZXNlcnZhdGlvbiBvYmplY3QgaXMgdGhlaXIgb3duLCBub3Qgdm0tPnJvb3QpLCBzbyBuZWl0aGVy
DQo+ID4gYW1kZ3B1X3ZtX3ZhbGlkYXRlKCkgbm9yIGFtZGdwdV91c2VycV9ib192YWxpZGF0ZSgp
ICh3aGljaCBvbmx5DQo+ID4gaGFuZGxlcyB0aGUgVk0ncyBldmljdGVkIGxpc3QpIGNvdmVycyB0
aGVtLiBBcyBhIHJlc3VsdCBhIHdwdHIgQk8gY2FuDQo+ID4gc3RpbGwgYmUgaW4gVFRNX1BMX1NZ
U1RFTSBhbmQgdW5yZXNlcnZlZCB3aGVuIGl0cyBvZmZzZXQgaXMgcmVhZCwNCj4gPiB0cmlwcGlu
ZyB0aGUNCj4gPiBhbWRncHVfYm9fZ3B1X29mZnNldCgpIHNhbml0eSBjaGVja3MgZnJvbSB0aGUg
cmVzdG9yZSB3b3JrZXI6DQo+ID4NCj4gPiAgIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0t
LS0tLS0tLQ0KPiA+ICAgV0FSTklORzogYW1kZ3B1X29iamVjdC5jOjE0ODYgYXQgYW1kZ3B1X2Jv
X2dwdV9vZmZzZXQrMHg3NS8weGEwDQo+IFthbWRncHVdLCBDUFUjMzoga3dvcmtlci8zOjEvMTE2
DQo+ID4gICBXb3JrcXVldWU6IGV2ZW50cyBhbWRncHVfdXNlcnFfcmVzdG9yZV93b3JrZXIgW2Ft
ZGdwdV0NCj4gPiAgIFJJUDogMDAxMDphbWRncHVfYm9fZ3B1X29mZnNldCsweDc1LzB4YTAgW2Ft
ZGdwdV0NCj4gPiAgIENhbGwgVHJhY2U6DQo+ID4gICAgPFRBU0s+DQo+ID4gICAgYW1kZ3B1X3Vz
ZXJxX3ZtX3ZhbGlkYXRlX2FuZF9yZXN0b3JlX3F1ZXVlKzB4NjI5LzB4OTYwIFthbWRncHVdDQo+
ID4gICAgYW1kZ3B1X3VzZXJxX3Jlc3RvcmVfd29ya2VyKzB4YTYvMHgxODAgW2FtZGdwdV0NCj4g
PiAgICBwcm9jZXNzX3NjaGVkdWxlZF93b3JrcysweGE2LzB4NDYwDQo+ID4gICAgd29ya2VyX3Ro
cmVhZCsweDEzYy8weDI5MA0KPiA+ICAgIGt0aHJlYWQrMHhmYi8weDE0MA0KPiA+ICAgIHJldF9m
cm9tX2ZvcmsrMHgxYjYvMHgyYjANCj4gPiAgICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAN
Cj4gPiAgICA8L1RBU0s+DQo+ID4gICAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0t
LS0NCj4gPiAgIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+ICAgV0FS
TklORzogYW1kZ3B1X29iamVjdC5jOjE0ODUgYXQgYW1kZ3B1X2JvX2dwdV9vZmZzZXQrMHg5YS8w
eGEwDQo+IFthbWRncHVdLCBDUFUjMjoga3dvcmtlci8yOjEvMTI3DQo+ID4gICBXb3JrcXVldWU6
IGV2ZW50cyBhbWRncHVfdXNlcnFfcmVzdG9yZV93b3JrZXIgW2FtZGdwdV0NCj4gPiAgIFJJUDog
MDAxMDphbWRncHVfYm9fZ3B1X29mZnNldCsweDlhLzB4YTAgW2FtZGdwdV0NCj4gPg0KPiA+IGFt
ZGdwdV90dG1fYWxsb2NfZ2FydCgpIG9ubHkgY3JlYXRlcyB0aGUgR0FSVCBtYXBwaW5nOyBpdCBk
b2VzIG5vdA0KPiA+IG1pZ3JhdGUgdGhlIEJPIG91dCBvZiBzeXN0ZW0gbWVtb3J5LCBzbyB0aGUg
b2Zmc2V0IHJlYWQgaXMgYm9ndXMgKHRoZQ0KPiA+IHF1ZXVlIHdvdWxkIHJlc3VtZSB3aXRoIGEg
d3Jvbmcgd3B0ciBhZGRyZXNzKS4NCj4gPg0KPiA+IExvY2sgZWFjaCB3cHRyIEJPIGludG8gdGhl
IGRybV9leGVjIGNvbnRleHQgYW5kIHZhbGlkYXRlIGl0IGludG8gR1RUDQo+ID4gaW5zaWRlIHRo
ZSBkcm1fZXhlY191bnRpbF9hbGxfbG9ja2VkKCkgYmxvY2ssIG1pcnJvcmluZyB3aGF0IHRoZQ0K
PiA+IGNyZWF0ZSBwYXRoIChtZXNfdXNlcnFfY3JlYXRlX3dwdHJfbWFwcGluZykgYWxyZWFkeSBk
b2VzLCBzbyB0aGF0IHRoZQ0KPiA+IG9mZnNldCByZWFkIGxhdGVyIGlzIHNhZmUgYW5kIGNvcnJl
Y3QuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vz
ZXJxLmMgfCAyNg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAyNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gaW5kZXggMTdjYzQ4ZDg3YzRkLi41OWFhNDgwMmMx
MTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vz
ZXJxLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEu
Yw0KPiA+IEBAIC0xMDU0LDYgKzEwNTQsMzIgQEANCj4gYW1kZ3B1X3VzZXJxX3ZtX3ZhbGlkYXRl
X2FuZF9yZXN0b3JlX3F1ZXVlKHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyDQo+ICp1cV9tZ3IpDQo+
ID4gICAgICAgICAgICAgZHJtX2V4ZWNfcmV0cnlfb25fY29udGVudGlvbigmZXhlYyk7DQo+ID4g
ICAgICAgICAgICAgaWYgKHVubGlrZWx5KHJldCkpDQo+ID4gICAgICAgICAgICAgICAgICAgICBn
b3RvIHVubG9ja19hbGw7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAg
ICAgICogVGhlIHBlci1xdWV1ZSB3cHRyIEJPcyBhcmUgbm90IHBhcnQgb2YgdGhpcyBWTSAodGhl
aXIgcmVzdiBpcw0KPiA+ICsgICAgICAgICAgICAqIHRoZWlyIG93biwgbm90IHZtLT5yb290KSwg
c28gdGhlIHZhbGlkYXRpb24gYWJvdmUgZG9lcyBub3QNCj4gPiArICAgICAgICAgICAgKiBjb3Zl
ciB0aGVtLg0KPg0KPiBUaGF0J3Mgbm90IGNvcnJlY3QuDQo+DQo+IFRoZSBXUFRSIEJPcyBhYnNv
bHV0ZWx5IG11c3QgYmUgcGFydCBvZiB0aGUgVk0gb3Igb3RoZXJ3aXNlIHRoZSBNRVMvQ1AvU0RN
QQ0KPiBGVyB3b3VsZG4ndCBiZSBhYmxlIHRvIHJlYWQgaXQuDQoNClRoYW5rcyBDaHJpc3RpYW4s
IHlvdSdyZSByaWdodCB0aGF0IOKAnG5vdCBwYXJ0IG9mIHRoaXMgVk3igJ0gaXMgaW5jb3JyZWN0
IHdvcmRpbmcg4oCUIHRoZSBXUFRSIEJPIGlzIFZNLW1hcHBlZC4NClRoZSBpc3N1ZSBJ4oCZbSBo
aXR0aW5nIGlzIGRpZmZlcmVudDogaW4gcmVzdG9yZSwgYW1kZ3B1X2JvX2dwdV9vZmZzZXQoKSBj
YW4gYmUgY2FsbGVkIHdpdGhvdXQgdGhlIFdQVFIgQk8gcmVzZXJ2YXRpb24gbG9jayBoZWxkLCB3
aGljaCB0cmlnZ2VycyBXQVJOX09OIGFuZCByYWNlcyB3aXRoIEJPIHN0YXRlIGNoYW5nZXMuDQpJ
4oCZbGwgc2VuZCB2MiB3aXRoIGNvcnJlY3RlZCBkZXNjcmlwdGlvbiBhbmQgYSBuYXJyb3dlciBm
aXggdGhhdCBvbmx5IGFkZHMgZWFjaCBXUFRSIEJPIHRvIHRoZSBkcm1fZXhlYyBsb2NrIHNldCBi
ZWZvcmUgcmVhZGluZy91cGRhdGluZyBpdHMgR1BVIG9mZnNldC4NCg0KVGhhbmtzDQpKZXNzZQ0K
Pg0KPiA+ICsgICAgICAgICAgIExvY2sgYW5kIHZhbGlkYXRlIGVhY2ggaW50byBHVFQgaGVyZSBz
byB0aGF0DQo+ID4gKyAgICAgICAgICAgICogcmVhZGluZyBpdHMgR1BVIG9mZnNldCBiZWxvdyBp
cyBzYWZlIC0gbWF0Y2hpbmcgd2hhdCB0aGUNCj4gPiArICAgICAgICAgICAgKiBjcmVhdGUgcGF0
aCAobWVzX3VzZXJxX2NyZWF0ZV93cHRyX21hcHBpbmcpIGRvZXMuDQo+ID4gKyAgICAgICAgICAg
ICovDQo+ID4gKyAgICAgICAgICAgeGFfZm9yX2VhY2goJnVxX21nci0+dXNlcnFfeGEsIHRtcF9r
ZXksIHF1ZXVlKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdHRtX29wZXJhdGlv
bl9jdHggd3B0cl9jdHggPSB7IGZhbHNlLCBmYWxzZSB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgICAgICAgIGJvID0gcXVldWUtPndwdHJfb2JqLm9iajsNCj4gPiArICAgICAgICAgICAgICAg
ICAgIGlmICghYm8pDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0K
PiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgIHJldCA9IGRybV9leGVjX3ByZXBhcmVfb2Jq
KCZleGVjLCAmYm8tPnRiby5iYXNlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgVFRNX05VTV9NT1ZFX0ZFTkNFUyArIDEpOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgZHJtX2V4ZWNfcmV0cnlfb25fY29udGVudGlvbigmZXhlYyk7DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkocmV0KSkNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZ290byB1bmxvY2tfYWxsOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAg
ICAgIGFtZGdwdV9ib19wbGFjZW1lbnRfZnJvbV9kb21haW4oYm8sIGJvLQ0KPiA+YWxsb3dlZF9k
b21haW5zKTsNCj4gPiArICAgICAgICAgICAgICAgICAgIHJldCA9IHR0bV9ib192YWxpZGF0ZSgm
Ym8tPnRibywgJmJvLT5wbGFjZW1lbnQsICZ3cHRyX2N0eCk7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICBpZiAodW5saWtlbHkocmV0KSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z290byB1bmxvY2tfYWxsOw0KPiA+ICsgICAgICAgICAgIH0NCj4NCj4gQ2xlYXIgTkFLIHRvIHRo
YXQsIHRoaXMgaXMgY2xlYXJseSBub3QgY29ycmVjdC4NCj4NCj4gUmVnYXJkcywNCj4gQ2hyaXN0
aWFuLg0KPg0KPiA+ICAgICB9DQo+ID4NCj4gPiAgICAgaWYgKGludmFsaWRhdGVkKSB7DQoNCg==
