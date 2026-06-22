Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5BACDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 09:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB4910E58D;
	Mon, 22 Jun 2026 09:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YDvHlI9E";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6019910E58D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 09:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMwPJd7P7/xZ7syuWzC4+jElNDO+6EMyNnL4x1UlHbAgUkr5NJuie2+0sTKZk1l/R80ixevd67VAmnMBOE+1bYsNr8MeqBzX9BbqJzMt2wG8beelJdDpx4JD1UDmPXEwvr1LmwI3fOcAmddrGWtkoyrFBiKyAgMX8irp7CeGkugatG9XJZnbaYArknfqAg7DbjsbLR0lA2c8jiRjP3xgmoeo7qChy4NWa15gwpjczRDHeeX5WtxN7kw01xSBKkS27ExhXB190b13ilhiM2BbEo/aY66Bt5mvTPXf8LGnVhbCjd8pTYwdHgsXERJtRIfR0Qt+UXio1TeZAc7bl3n+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4GfdSNc6SCEUCCGMPbp+idZxuCHNBtfZiYiecHiuaE=;
 b=QqNdSejJZk+3I92U2pDbjAChw5duq6uQcebWCV4t9uRMHsGKT+KELzOVJwCuYa1QlsvccHRqrJIsDBkmrd3UAZu6gtnQ6VnzLDEL3Tu2X9a/pARiUOkGjzYYduvQ9yzdC3Yu8ebkeWFoQCCm8k5nZPOddFLsKFIFBAsJIeEs34hBbirxdlcppMZZ1dtoXikNDvD4tyLs05R3Ya/scbMIVNz9JypniVUdzWXn7xJsfXX2AW9KQNCAhDd2kUiTK6Ar9ltWr4jC0Khnvn91oz5Bfmdy1ywyeB219W7cJtV1FjXGWD4RL8xXC9WBKu1f1HOBpA40x1467c1TzSVXRRp6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4GfdSNc6SCEUCCGMPbp+idZxuCHNBtfZiYiecHiuaE=;
 b=YDvHlI9E1aUkc5If0RxOmdK7DONXozVH9C3EJt9LvI488nQo5haNJT/hW8ylFC2rhfkEO0fgBzwe5sI2ZgIo1x5cozkLTj2JSfdol1QWk+yfTb4ivyQGhneIMYNCEv3BdCWq/tTLmwTzkllqI7fa4kRofCFUpz6ns46FAecT+vc=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 09:10:41 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 09:10:41 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Thread-Topic: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Thread-Index: AQHdAA+QIv+XVhj5VEWKsTwNX70BhrZKPm0AgAAMQFCAAAK4MA==
Date: Mon, 22 Jun 2026 09:10:40 +0000
Message-ID: <IA0PR12MB8208536DAC79A742DB687A7B90EF2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
 <5eadae57-bc7c-4c22-9e02-04c32d7e6e97@amd.com>
 <IA0PR12MB82087A22BE651E5AE05C3B6390EF2@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB82087A22BE651E5AE05C3B6390EF2@IA0PR12MB8208.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T08:59:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|BY5PR12MB4178:EE_
x-ms-office365-filtering-correlation-id: ef8bad67-0f5b-4f15-ae00-08ded03e21d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|38070700021|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: 5u4lOcqhmDpgRrTanyXXzhizi4Zm1rpEy+dfa637kPD66vqiVxEnt1Jy2PpGac5oCIx3m9vIPtug+ZWVHf/3vXBDoRr6G8NqxcA+guH+7oNtCm2+CgfWNM/O6GKJrwI9Ys4McmasexdheRiQFo+d7wbngvSEAFfs7wq6DQOBzZwbCs3ePc235nMubViDVWCVfjJ9JCzNUUPm6JuSm1TIdCFD0W50476+pqPzCHP29myn9BlVbsa8HzYOZZ8OpngVBgMbuYLl4rpenOFscIUQ9Xx7C/piKMSVfz8Ml7ccDQJUqTcgB+82NOlv0SOn5jcbHO5nxmXKbZTUfLPA9BxM6CVT86QHt3ieyQN+opkEFXZFiLUcJwUATBu4kuR0OuTOMJQiG13NhmNfuOWUEqFWXN4gJiFyywMxqt5ZzyxOoDfoQGZGY+tNqWt2unkLDq1BfUQpSNpraj/Yd/ag1TjbuHLU1UCwoFtSlSqDBuUC0VrpW3n9kqjEZWu1nc5d9OSVI6IjmHzgZbP5Vocm74Hw4mOqxZvwyiDELR9ncqMHgMHSxrqMsOvQp1k3+VEZ47K2lLIyz8KZTpiZ+UMEmHKkoXPj7qWjOXWS8s1ZmjyFKtp2LwUXLpjOpS0v8sNVrV0Vbwvjn+sVqnIle/Ke4O3r3qHyj9hur3wtYCdj9SpQ+z8apiaGPC3fyDXvj9gdOqr3QR0bzzZ0+XtNu4TCUFviH2rmxE07KJ8dPWAUHYK8VQw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0tzcUUyZ3NNR1VoZzJaaHBEenVHeG5hNVZGWXhWZjR2c2wwZ2ZpVENMU1dR?=
 =?utf-8?B?MUZtRG9vaVdYby94bFByM3BPYlRBbVZCeG45REkzejdSSU5PUVp1c1d4WUhk?=
 =?utf-8?B?T29yWnRUYmUwMmJPQ3cyQVVqWWhUL0M1M1hWQU1FWnRBa2VCOTBmbDRxMFI2?=
 =?utf-8?B?cXI5Y2Yyb3pnRkR4WTExSnYrNlBjUW5hK3hFT2dEYTBMT3ZBOGIrRm4vS0xZ?=
 =?utf-8?B?OGRleGoveW0zRExXWjhVZjB6eFVkU1g2OHB0M3pYWDZYS3JFb2prbGxiQTNs?=
 =?utf-8?B?NngzUHlRaXVhN2pqUkhLMGdzR1krOGdnZVFrcnVGd050anp4dEU3RmY3akdQ?=
 =?utf-8?B?eFZ5bE5BeEd3dXNtc1AxMXJsb0ZMczQxdmhhL0xYdXpmWUdNUnVubzhUTUkz?=
 =?utf-8?B?T1V1SHIzVlkrbWpNQ3VwK2ZFMC9RdnRnM04xSGdjUjZEUVhwbzZlbHJqSW1a?=
 =?utf-8?B?Vlg0UUN5QUNRWUpOdEJPSzZRelA3bDltNEtUeDhyRHhQMHFqeUNwRnBoUTd4?=
 =?utf-8?B?WGZLVitSSStJTG0rSU9RVkFoS2pGeHpveWpTTXN2Z1hQWGc3N054aHMzK1VY?=
 =?utf-8?B?TFgxZUpoZVZyQnE3U2Z0L0pKYWhjbUpFQVBuSStGTmxROUxONVZPZjVYc1Fo?=
 =?utf-8?B?L2VaazlBTlJKLzRqak1NcGw3ejFpMkdnUmx3NDFNVHdDclNVQ3gxRnQrb0pi?=
 =?utf-8?B?RWMrRTFXelZyTmMybHYwem80bXA1dHFyb3FjN0tLVFFDM1JGaUlZZUk3SUJk?=
 =?utf-8?B?NkF2WG5ybENEZWhsL25NV3pud2F0UjduWkNPSU80RlhZN2VkUFZlYUVTU25h?=
 =?utf-8?B?VEhmTUh4cm9vSmQwellrZXNPaksraVhSbjVST0d5Y3pLbG1GVEhtMDc1WGZn?=
 =?utf-8?B?ZnJmNnhkSytlenZnWG1qWXZZblB6M2U4QmEwZGo1OTEvNE9sbEhWdGhuTDI2?=
 =?utf-8?B?cnMwTHJqckVkVHNGbmEwaGs4VGRYN2p0bzN4VmFtSUZvcFU4RnZnMlZSZ25i?=
 =?utf-8?B?ckpCSzFRaEhZeTRGNGRXclIyUFk5cGVLZUthTzVBOWlvS0tWZWZjTDcwRHYz?=
 =?utf-8?B?NWpLRGl4Vis5R3NKRFJUODFiWTRHeWpXamN4MmY3U2xld3BuYjVYV2I3RUVu?=
 =?utf-8?B?KzkweWg0dnFIQ0Raa2d2cEpyTFVCcUZUb0VpMXlmeE14MmowQ3ZoVlVIdmVZ?=
 =?utf-8?B?eVd1QjdxRzhXYVFzd0ZqR054MHF1Umh5UDFsRlY4bWI2K2VKVmZGbFNYK2lx?=
 =?utf-8?B?Qzl0L1lPQjdFOG9oVDdBUVcvbE15VVp3bGZrR0R5bHJrOGQ0ZGRGNmUydm4y?=
 =?utf-8?B?cXdSejFPZCtFQ05CSHE2MWRiaFJoazh2WGJhSnhuaVJTNlptelFjdlJoblFs?=
 =?utf-8?B?YnNaSEtEcUtndzhnUTg5K3RULy9MT3MxMjBJRzNmdUYzTndCYVpQQjUrSEpE?=
 =?utf-8?B?OUdVdDhtMlRkanRJUVZqdWtpQzAvRFd0L0xUd3Bld0g2cHBKWnVBQlpVZmlp?=
 =?utf-8?B?dzBWMG12ZTZIWjFhWGl4OEFQNVEvaUp3M3lwQ3VyRzFVS1FGR0pJcERkTXNy?=
 =?utf-8?B?S2FPVXpKNVIvS3ZTN0k1dVpIeWhKcU5nenlSaVpNVXBXejZTZml6K2R3SDU3?=
 =?utf-8?B?aWxxY25CTTRLSXdRTkx0Qm9CVUlKQVNWdHBDTUNjelBCVnJaQ016T0Z0LzM5?=
 =?utf-8?B?MUFBa1JGM1RBWm9ORWRxZ0RiY3UrcDBPbFdlZ1hIWU5hc28zcTNqUGVPUS9K?=
 =?utf-8?B?dzJVQW15ZWFTWjNVdEZXb2cyR3BPUk00Q2NMWUZqc0kzQ3JvQ01DS2VQOUgy?=
 =?utf-8?B?dzE2OWtkOXlnYkNoKzcrZURFcW1LSHQrN0Y5aXRrNGdKNVMvUUVGU1M3R1VO?=
 =?utf-8?B?T2lRL0lhMGJqSEVyTEQ5dGsvZUJ1YXQ1Q0RZRzhGWEQyNkhVYkFIY3RPMjMz?=
 =?utf-8?B?bHRNalNrTWZsUDhlQ1BFY00yaGtuZkpPK3JaMDF2dFZ2Z0ZLVS9FYjg1ODFB?=
 =?utf-8?B?L0w2eTFoN0o4eW1aL0pKcFVYN1U5RDhtYThpTFBzcVhodTZ6ZkpFTm80VkNw?=
 =?utf-8?B?cU9LZUFZZldVK3VkV2srL0NjSURsM2FjUEkzaEFtY3RxZjB6d0ZQbks5N0ox?=
 =?utf-8?B?NlF3dnBvdmpQRmpCSFpycTloZFZ1V1EzcURzVHpKdFo5TFFORlhZVEVEd3J5?=
 =?utf-8?B?QzhXOXh2Q0pkdVMzbGJwSkpNR1pvQUtnS1NhYU9QT1NUUU5uSUhiTklrdFJE?=
 =?utf-8?B?bjk1VjB2eE9kVkdCMU1XemJUaHFSR2cyVThyZ3FmcTdhdSs1bC9yUmRFbHRN?=
 =?utf-8?Q?Alpga4tXt51DWY1tLo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8bad67-0f5b-4f15-ae00-08ded03e21d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 09:10:40.7500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qgw+YRoKi+DDwk7MZ51KEFbacMpZ76JP3BHeZwW3dxOO+xfPTm2z8JyWCaAcVDeB2NO60lh4X5wGxVBWXb4KOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFO
TVVHQU0sIFNSSU5JVkFTQU4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDIyLCAyMDI2IDI6MzIgUE0N
Cj4gVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVj
aGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgVGltdXIgS3Jpc3TDs2YgPHRpbXVyLmtyaXN0b2ZA
Z21haWwuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OiBSZWR1Y2Ugc3Rh
Y2sgdXNhZ2UgaW4gSVAgYmxvY2sgc29mdCByZXNldA0KPg0KPg0KPg0KPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIEp1bmUgMjIsIDIwMjYgMTo0NSBQTQ0K
PiA+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5j
b20+Ow0KPiBEZXVjaGVyLA0KPiA+IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT4NCj4gPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFRpbXVyIEtyaXN0w7Nm
DQo+ID4gPHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS9hbWRncHU6IFJlZHVjZSBzdGFjayB1c2FnZSBpbiBJUCBibG9jayBzb2Z0DQo+ID4gcmVz
ZXQNCj4gPg0KPiA+DQo+ID4NCj4gPiBPbiA2LzE5LzI2IDE5OjE3LCBTcmluaXZhc2FuIFNoYW5t
dWdhbSB3cm90ZToNCj4gPiA+IGFtZGdwdV9kZXZpY2VfaXBfc29mdF9yZXNldCgpIGFsbG9jYXRl
cyBhbiBhcnJheSBvZiBBTURHUFVfTUFYX1JJTkdTDQo+ID4gPiByaW5nIHBvaW50ZXJzIG9uIHRo
ZSBzdGFjay4gT24gNjQtYml0IGJ1aWxkcyB0aGlzIGNvbnN1bWVzIGFyb3VuZA0KPiA+ID4gMTI4
MCBieXRlcyBhbmQgdHJpZ2dlcnM6DQo+ID4gPg0KPiA+ID4gd2FybmluZzogc3RhY2sgZnJhbWUg
c2l6ZSAoMTMwNCkgZXhjZWVkcyBsaW1pdCAoMTAyNCkNCj4gPiA+DQo+ID4gPiBNb3ZlIHRoZSB0
ZW1wb3JhcnkgcmluZyBwb2ludGVyIGFycmF5IHRvIGhlYXAgYWxsb2NhdGlvbiB0byByZWR1Y2UN
Cj4gPiA+IHN0YWNrIHVzYWdlLg0KPiA+DQo+ID4gQ2xlYXIgTkFLLg0KPiA+DQo+ID4gR0ZQX0tF
Uk5FTCBhbGxvY2F0aW9ucyBhcmUgZm9yYmlkZGVuIGluIHRoZSByZXNldCBwYXRoLg0KPiA+DQo+
ID4gWW91IGNvdWxkIHVzZSBHRlBfTk9XQUlUIG9yIEdGUF9BVE9NSUMsIGJ1dCB0aGF0IHNob3Vs
ZCBiZSBhdm9pZGVkIGFzDQo+IHdlbGwuDQo+ID4NCj4gPiBXaHkgaXMgdGhhdCBhcnJheSBuZWNl
c3NhcnkgaW4gdGhlIGZpcnN0IHBsYWNlPw0KPg0KPg0KPiBUaGFua3MgQ2hyaXN0aWFuLg0KPg0K
PiBMb29rcyBsaWtlIHRoZSB0ZW1wb3JhcnkgYXJyYXkgaXMgY3VycmVudGx5IG9ubHkgdXNlZCB0
byBjb2xsZWN0IHRoZSBzdWJzZXQgb2YgcmluZ3MNCj4gYWZmZWN0ZWQgYnkgdGhlIElQIGJsb2Nr
IHNvZnQgcmVzZXQgYW5kIHBhc3MgdGhlbSB0bw0KPiBhbWRncHVfbXVsdGlfcmluZ19yZXNldF9o
ZWxwZXJfYmVnaW4oKSBhbmQNCj4gYW1kZ3B1X211bHRpX3JpbmdfcmVzZXRfaGVscGVyX2VuZCgp
Lg0KPg0KPiBhbWRncHVfZmlsdGVyX3JpbmdzKCkgc2ltcGx5IGNvcGllcyBtYXRjaGluZyBlbnRy
aWVzIGZyb20NCj4gYWRldi0+cmluZ3NbXSBpbnRvIGEgdGVtcG9yYXJ5IGFycmF5LCBhbmQgdGhh
dCBhcnJheSBpcyBvbmx5DQo+IGl0ZXJhdGVkIG92ZXIgYnkgdGhlIG11bHRpLXJpbmcgcmVzZXQg
aGVscGVycy4NCj4NCj4gTG9va2luZyBhdCB0aGUgaW1wbGVtZW50YXRpb24gYWdhaW4sIGl0IHNl
ZW1zIHBvc3NpYmxlIHRvIGVsaW1pbmF0ZSB0aGUgaW50ZXJtZWRpYXRlDQo+IGFycmF5IGVudGly
ZWx5IGFuZCBoYXZlIHRoZSBoZWxwZXJzIGl0ZXJhdGUgZGlyZWN0bHkgb3ZlciBhZGV2LT5yaW5n
c1tdIHdoaWxlIGZpbHRlcmluZw0KPiBiYXNlZCBvbiB0aGUgcmluZyB0eXBlIG1hc2suDQo+DQo+
IE1heSBJIGtubyBwbHMsIHdvdWxkIHRoYXQgYXBwcm9hY2ggbWFrZSBzZW5zZT8NCj4NCj4gUmVn
YXJkcywNCj4gU3JpbmkNCj4NCg0KSSB0b29rIGFub3RoZXIgbG9vayBhdCB0aGUgaW1wbGVtZW50
YXRpb24uIFRoZSB0ZW1wb3JhcnkgYXJyYXkgaXMNCmN1cnJlbnRseSBvbmx5IHVzZWQgdG8gY29s
bGVjdCB0aGUgc3Vic2V0IG9mIGFmZmVjdGVkIHJpbmdzIGFuZCBwYXNzDQp0aGVtIHRvIHRoZSBt
dWx0aS1yaW5nIHJlc2V0IGhlbHBlcnMuDQoNCmFtZGdwdV9maWx0ZXJfcmluZ3MoKSBzaW1wbHkg
Y29waWVzIG1hdGNoaW5nIGVudHJpZXMgZnJvbQ0KYWRldi0+cmluZ3NbXSBpbnRvIGEgdGVtcG9y
YXJ5IGFycmF5LCBhbmQgdGhlIGhlbHBlcnMgb25seSBpdGVyYXRlDQpvdmVyIHRoYXQgYXJyYXku
DQoNCkZyb20gd2hhdCBJIGNhbiBzZWUsIGFkZXYtPnJpbmdzW10gYXBwZWFycyB0byBiZSBhIHN0
YWJsZSBkZXZpY2UgcmluZw0KbGlzdCwgc28gaXQgc2VlbXMgcG9zc2libGUgdG8gZWxpbWluYXRl
IHRoZSBpbnRlcm1lZGlhdGUgYXJyYXkNCmVudGlyZWx5IGFuZCBoYXZlIHRoZSBoZWxwZXJzIGl0
ZXJhdGUgZGlyZWN0bHkgb3ZlciBhZGV2LT5yaW5nc1tdDQp3aGlsZSBhcHBseWluZyB0aGUgc2Ft
ZSByaW5nX3R5cGVfbWFzayBmaWx0ZXIuDQoNCkhpIFRpbXVyLCB3YXMgdGhlIHRlbXBvcmFyeSBh
cnJheSBpbnRlbmRlZCB0byBwcm92aWRlIHNuYXBzaG90IHNlbWFudGljcw0KZm9yIHRoZSBhZmZl
Y3RlZCByaW5ncywgb3Igd2FzIGl0IG1haW5seSBpbnRyb2R1Y2VkIGZvciBjb252ZW5pZW5jZT8N
Cg0KSWYgdGhlcmUgaXMgbm8gc25hcHNob3QgcmVxdWlyZW1lbnQsIEknbGwgcmVzcGluIHRoZSBw
YXRjaCBieSByZW1vdmluZw0KdGhlIHRlbXBvcmFyeSBhcnJheSBhbHRvZ2V0aGVyLg0KDQpSZWdh
cmRzLA0KU3JpbmkNCg==
