Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B46C5DF94
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 06:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C805510E8E3;
	Tue, 25 Aug 2026 06:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GLsNZI15";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C6B10E13B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 06:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNw4WsXpPFiSJtOGVp28r2KZYy4auPZ/2nqEJqwiWraZHeNXOgZ+gQYfg7mmJP/GA4a+LwefefIIHN0ZMDtzQDfdlHiQ0ev0xxGtVkHWWbvDbmBJB+riexIG7t3/wZnn2Zo2mkQ97JTCSa22/WL1FF8PKJMFh95pzuu2In8xWv12h1zasJton3Amx8WtANDYXz8b0p8F+TZhXg5/TOwlvO4/odSrBMq0jrdlf/Bq/AAJDBgnnppiZ9x1dq+xDdt/iM8P0p0hiPSxUqaHmQSpErRyaHZtHZnAEis/Lyeif3KQmdTGV9QndrBVjfRzyZa1DablOicE9XGkUJkBvz3oJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd4XFbcLfZIU7RJYRoftCltAy9TfWjV2BfgO3M996IA=;
 b=GdCxhGys499kppZYPSdmqkgTjsl1CXtrBb7uj6uT8Tt/tfyo1LMyP2/9sMW/4ZFK+GmWqWidU1BMlOq/2ksW1lc9T4lFSE2b/oq1yaA2Z+jI9AQxuU5sS+w1r04Yldvx1jIfgKFCBb4Bap/cvmBtoOUQcVWWVcFjvDOxIQePY5Epv9vg5LAaKib0cDTW31fwtcG7PRLvXkSoeU3t3WBihEmBwOukc5bou/cBV+xbWjv8Rn4CccvW/xqOO0Y/6adFkqClOt+RThLf8SL+ft37HvPwd9Jb5rN7Av/xPTT7/7JNvBFIkaPCt6cBweHdIChe+rIFtsqCTHyuz7O6CJO0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd4XFbcLfZIU7RJYRoftCltAy9TfWjV2BfgO3M996IA=;
 b=GLsNZI15F34NCLsnDhcocI7jTdxHPncqqHKFo1PcjuzvNuPdlQ+sKpdEfUDbQVehlsz/mmWvVVPr53W7uM3PzaJj7lJvkuZ/ifC9jeQt5LCf6RGaN69n7g6aoFm87eJJlTcrdbQKXgRyvTzAf/dRw3VSwppCjyVQaMyT+GydWpc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 06:18:51 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:18:51 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/gfx8: only apply compute quantums to KCQs
Thread-Topic: [PATCH] drm/amdgpu/gfx8: only apply compute quantums to KCQs
Thread-Index: AQHdMKzpCeiyEsdbg06Sqh89T2nrXbatvE0AgABGVDA=
Date: Tue, 25 Aug 2026 06:18:51 +0000
Message-ID: <DM4PR12MB5152CFFC0ABBB5BE8F99A624E3AF2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260820140433.2875442-1-alexander.deucher@amd.com>
 <CADnq5_PoahpM1GB-fum5rYgzrS2sA=bfpdWjb3m=iutxtX9J3A@mail.gmail.com>
In-Reply-To: <CADnq5_PoahpM1GB-fum5rYgzrS2sA=bfpdWjb3m=iutxtX9J3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T01:35:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA1PR12MB9002:EE_
x-ms-office365-filtering-correlation-id: 4f4cbd16-6672-4081-d095-08df0270bb84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|38070700021|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: LSORQgi2SOYDh+USGxpNRgCT8PTWfL7dP2AgQeCK0GwyVEn8Bw0+/nH/wQBQbAxatT92faEJmrjzhYJ4JusrvU2vHQ9RxLUkCAeOfSblbJiFtKSAhFeyofZVVGuYE+wN+dujzqxBpfHtMNEvKFL/OmYbPwvcppczix37Mt54GWlBSQcyE6cxEz9d2pPLc3Jpi9a+4lQ1aYn27rioCywcKZlGWqL4Iloe5lJFDHSRuhFc/dDgF5KwxLFg12qUHCTulkiEkAv1cwl5b3iMbdID2Huy9cbfIuWLpO0NpjGhrYgk6vRQ9X0xITedRwo+Etu3xFMcHAC0Rthk2QIUHI5LsU1yGwnpHjY3wVRJMvv93G85RhUY36xjj8EnU97TpHjPo/QPnCqmHwXsChcbTC/3b5paLYK4dXmL9k0mfpVb6IPBNpETvVvp55toAhpx+HmPG7TR0JGM83nMpXCsb5FPLr+xX0tgpF5qQiYjLzd4HQKOIunyU8i0Va0gDDED/HRK9haVjHHv6Z7y4I3n7kQS03b0Xec25UfkeRXx0tyUgRxicTpqcePVMohkCt2DoRwpskOrghm87sbqjluAR7OAypdDdP5mPa3tTwnT7q3YM9qzjkkMn6d4Ja1EAAbFywh1644hZBG0O2pjUJp91/tPdsazxUGD8ZbIH2Ieykqi5dQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG85dlQxYmR4VDkyRDFMSERYeDJSaHpEZEFONDVtL1JaK2RQVUx4RExqRDR3?=
 =?utf-8?B?QkVjYUd2NnNGQVpSNmRRTnpDc3ZudFkrcXJYVDF0b21Gbm1PNzNtdVBmMXlC?=
 =?utf-8?B?ZUVJRTlseDhESmxBWms4VHZSVlBqN3g0Ukp5NXhSSlBFU1BPZEludTZoZ2xO?=
 =?utf-8?B?Ym54S3VlRndEZ3J0OHIzZTRSc3RiUUpLK3JnV21CZEhOZlNkQ2puMHpSSG1x?=
 =?utf-8?B?VVRpNlZ1VDNTdXVTclU3SHNhTmhuNmlDQUg1VUJYaVVla2VoOEdkOFl0QUQ0?=
 =?utf-8?B?b09qVFZWRDNRS0dCc0FkdXJNMTdEaGxHcVZnTTlwMnc1SWVjM2I1YUhMVFU5?=
 =?utf-8?B?RmVrNDc1WEFJSnAwUjZhak9aaThHQy9QWUNWN3FxTG5uQU5kdjJ4UHJ0cFQz?=
 =?utf-8?B?a2EyVGtGNUpEakdQS29pTmJVTy9nNFhGSHhNTXJOWGNCUXpsQXB4OHAyTTlj?=
 =?utf-8?B?eXlZQmF6bkNYN0RDTjJKNG1SQzBmZDAra2xUbUMvQjh3NFRkeWEvWHhCa01M?=
 =?utf-8?B?WmxHSXBoVjYwNFJxWTBnTjRwQ1diK0RXcldQbk5NbkwwVEYzOFFFS2tuOTEx?=
 =?utf-8?B?NkxUU0tONUsvZnN6b0hlY01hWGZmVlFXSFNQWjBKOHNEaDNuM2JEWDZDZXc1?=
 =?utf-8?B?bnZMOW5wMnFQa2pHTDZpb0xDdFJFUkh4UXNWNUFaR0pzRVFGN2FQYWRiMXVp?=
 =?utf-8?B?azRVUytzcVJnNnl6OWpRTDlhUFZORmlkcnBuR0JTbkhiUFpqelMwMjlCZ1ND?=
 =?utf-8?B?U0JQNWs5VzV3eGZkZ0Z4dUcrMlRaa0lPcXZtRGg5RWR6cEdCdEVZRTRXaDAy?=
 =?utf-8?B?OU91dzY4aVdEeXBMQ045b0xHVkxlLzBPR2hWLzZhQm1MVVNCK0VYWThuOUZo?=
 =?utf-8?B?WC9IUHJHS3prYlpXVkh4cFlWSElBSm1aUU9QelVSZ3dqYTlLMEVtRWNiSlF4?=
 =?utf-8?B?M1BVVkppeW43dkV5d3U2QXcweWU5dGVKK2MxblNOcGY5N0pGaU56MXZyUkZ2?=
 =?utf-8?B?a2tFZzNidlIrSXBFWGpsNU5IZlJ6WDdhYUFKTy84S2VONFR4MklNZ21nU1g5?=
 =?utf-8?B?MXlLd29lZmd6NFJ0TXFkV2oya0o3OE5IT05QYWJqaWl5VXF5QXh4ejhVRWNp?=
 =?utf-8?B?STVJQ29RYWdoZlpaWFJQMEtNa0dTVFRGZE9lM2RaNzJENmpVbzZ3WDhpa1RB?=
 =?utf-8?B?YUpLNEMyQW53UmdWc3ZPZ0p4Y0VQKysxamZtTzhCZ09ZRURmSTFpSEVobThZ?=
 =?utf-8?B?Y3dYNnFkK0E5eVNVNG85NVZFSlBvZTA1UzlOckx1VXpnTFJZbjBjY2p5R0lu?=
 =?utf-8?B?amtVNUw2WUN3c3M4bmJ0aUIvZnhWUTZobzF1bnBCY1I4MmtqQTVxdTBQbWV0?=
 =?utf-8?B?bFBOaHVNYUNzMitLUkxCNnoweVorTjZndDNQUWhYaUhHUXcxc2U2eFRRYTdj?=
 =?utf-8?B?V2ZRMXEvQkl0N0hROWZ5dEpMYlZuMGdJZVQ3S1VicEc4VUY2M1pKVXBxVEF5?=
 =?utf-8?B?TW80YytEYmFMdDE2MHlMb1EvZ0UzZnZQdnRjNmV1RmxpSGxkQ2pyTEpra2RX?=
 =?utf-8?B?a1JJQkJlb3kraG1QNmhTdHZaTzlRRE9ZWU5RRDVMWnNId0FaN0V6U2V3U3JL?=
 =?utf-8?B?aXFkSXAyNjdtRG5acCtQQzQwRWtpY20weUU1blR3YzFCWFdBazEvNHZWZ3pr?=
 =?utf-8?B?TWtaSWVFU3ZETnBrWjhrMVIveWlhUklTYm1mUkVUSjVla3o3dXFlVDdXNHli?=
 =?utf-8?B?ckRWcmV3cUdrL0tIWHFFVUs2S0tic1Z3SkxUSjFodUNiVVpzajR6MVhFbDJP?=
 =?utf-8?B?a0hoRXR6SmZTVFhUU0ZXT0JyUEkybHIrbjJra3BvN2U4Vm5XTVI1Y0lTQVN6?=
 =?utf-8?B?UnkxcnBBWEMzUDk4cTZ0S3VseHJmR3JmN2ZFUTNhTndvNFpuTnVjR3JVN0hh?=
 =?utf-8?B?YUljSUZBWU1YdU5vZ2FLbWdua1hHM1h1UmYvRkREbmxiNkdqd1FZL3JoVGFH?=
 =?utf-8?B?cDJKNy85dkhKSkY2eTV2cFJhUC9VMWZkdVluTHJjUkJaZ0RTVUdacDExcXE2?=
 =?utf-8?B?YlpZN0hNUmZ3aVhpanMwbVRrUzJEaGgweGYvelJyNmlwYnl4ZitUYmN3aEhP?=
 =?utf-8?B?U0xTb0RwTEU0UXRJektrcElJK2dka1pTZCtIRkFzYm52RTBkTDZpWmQvdnZn?=
 =?utf-8?B?ZHBQNXpKeVFTanZ0ZUIxa3FDRkRiQkRmT2FMVHNBTWg4dlcrTnZZaFNvZFFH?=
 =?utf-8?B?WEV6MzRPSlZ4cUFLVm9YWmMwTUJYR0xCMU1BV24vU0VEbDRLOThBNTBqTUx1?=
 =?utf-8?Q?2k3nB5RwFOUxf6FGeV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4cbd16-6672-4081-d095-08df0270bb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 06:18:51.5234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUl/GJcrloGo0RThrtmUCBFE3amthdPh6oVKHFg8hzs1RhLqKvOqdta8AL6r70UwhjNz7TMapPOZf7De7EEpMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002
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

QU1EIEdlbmVyYWwNCg0KUmV2aWV3LWJ5OiBKZXNzZSBaaGFuZyA8amVzc2UuemhhbmdAYW1kLmNv
bT4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleA0KPiBE
ZXVjaGVyDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNSwgMjAyNiA1OjI0IEFNDQo+IFRvOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
Z3B1L2dmeDg6IG9ubHkgYXBwbHkgY29tcHV0ZSBxdWFudHVtcyB0byBLQ1FzDQo+DQo+IFBpbmc/
DQo+DQo+IE9uIFRodSwgQXVnIDIwLCAyMDI2IGF0IDEwOjEw4oCvQU0gQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IERvbid0IGFwcGx5
IHRvIEtJUS4gIFNlZW1zIHRvIGNhdXNlIHByb2JsZW1zIG9uIEtJUSBvbiBzb21lIEFSTQ0KPiA+
IHBsYXRmb3Jtcy4NCj4gPg0KPiA+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Au
b3JnL2RybS9hbWQvLS93b3JrX2l0ZW1zLzU2NTgNCj4gPiBGaXhlczogOTFjZjM0YmM1YTU1ICgi
ZHJtL2FtZGdwdS9nZng4OiBhbGlnbiBtcWQgc2V0dGluZ3Mgd2l0aCBLRkQiKQ0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyB8IDggKysrKyst
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhf
MC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jDQo+ID4gaW5k
ZXggZjdjMmIxNDlhY2QwYS4uNDI0MTQ1M2UwZWM4YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYw0KPiA+IEBAIC00NTQ2LDkgKzQ1NDYsMTEgQEAgc3RhdGlj
IGludCBnZnhfdjhfMF9tcWRfaW5pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcNCj4gKnJpbmcpDQo+ID4g
ICAgICAgICAvKiBzZXQgc3RhdGljIHByaW9yaXR5IGZvciBhIHF1ZXVlL3JpbmcgKi8NCj4gPiAg
ICAgICAgIGdmeF92OF8wX21xZF9zZXRfcHJpb3JpdHkocmluZywgbXFkKTsNCj4gPiAgICAgICAg
IHRtcCA9IFJSRUczMihtbUNQX0hRRF9RVUFOVFVNKTsNCj4gPiAtICAgICAgIHRtcCA9IFJFR19T
RVRfRklFTEQodG1wLCBDUF9IUURfUVVBTlRVTSwgUVVBTlRVTV9FTiwgMSk7DQo+ID4gLSAgICAg
ICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgQ1BfSFFEX1FVQU5UVU0sIFFVQU5UVU1fU0NBTEUs
DQo+IDEpOw0KPiA+IC0gICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9RVUFO
VFVNLA0KPiBRVUFOVFVNX0RVUkFUSU9OLCAxMCk7DQo+ID4gKyAgICAgICBpZiAocmluZyAhPSAm
YWRldi0+Z2Z4LmtpcVswXS5yaW5nKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHRtcCA9IFJFR19T
RVRfRklFTEQodG1wLCBDUF9IUURfUVVBTlRVTSwNCj4gUVVBTlRVTV9FTiwgMSk7DQo+ID4gKyAg
ICAgICAgICAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBDUF9IUURfUVVBTlRVTSwNCj4g
UVVBTlRVTV9TQ0FMRSwgMSk7DQo+ID4gKyAgICAgICAgICAgICAgIHRtcCA9IFJFR19TRVRfRklF
TEQodG1wLCBDUF9IUURfUVVBTlRVTSwNCj4gUVVBTlRVTV9EVVJBVElPTiwgMTApOw0KPiA+ICsg
ICAgICAgfQ0KPiA+ICAgICAgICAgbXFkLT5jcF9ocWRfcXVhbnR1bSA9IHRtcDsNCj4gPg0KPiA+
ICAgICAgICAgLyogbWFwX3F1ZXVlcyBwYWNrZXQgZG9lc24ndCBuZWVkIGFjdGl2YXRlIHRoZSBx
dWV1ZSwNCj4gPiAtLQ0KPiA+IDIuNTUuMA0KPiA+DQo=
