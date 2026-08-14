Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DE2C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 16:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CCB10E166;
	Fri, 14 Aug 2026 16:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I8t7UAoT";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0C310E166
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 16:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY+bAOGvlLpts1J17HNMXDrD4MmHQ8I5GYbBtKYSQE+zVLVccZiKFlW58fwB006pia3j4MTWm/bYtYResA2TPhb0R1JTJxQwIuJz45vf7g3Vs/xKqgvpEJn1wjgE+i9tCLiG8ObqiuSYNMNO7HfnInlrNJSRcmEWgB8L6MKgxi5BKwsWASi8N+AYVM7onvmD7KTulY7Emo6SbXsrAgLuVLnSokAIAgJLPk29s6qVd3hNys6Q7X+thWLyLI8+Nmgdw3qcj/bI77hOu0SgLKgoLmQ6gHS+yIuZ2ozuwmPfyuET2zhjm24Tpk9DIPcjntm1KH3AbsI2GyeMsbpmcff4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om8h9ahciBWa48ZU3MwJ1hYby5CzGTEbHERkNqVzxHY=;
 b=sCd4raWmoNtkagzEQjQVd5vVWmInmqxMXEA5TmGRjitLnmFEUTgTpZO6oybHZpYfaVJhGJAeCazn/mCdyMUwz2D3jF9k0Jm23Gy6G2z60yj51mviwuGl88yo8Pdcrc4fBGtwAD+HRBl9R6M83GYEc+nRQbrGt93qRpMyhUDCOOFLvVVCuDMXpS6OXE2ymHCFgbB6X3MUCQcp7mIwEeNIc212HchsoiQt25gfSkIsm2HDSQi/jqm/RFNjdUSPd4P6Gi7EtTIzqnLk5qty2+wdImfRtuSZuAgXKCzeaAccWS/0jvshrOAlKDwRoknKnf4HN3jVYmkqVy629mk7iYl46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om8h9ahciBWa48ZU3MwJ1hYby5CzGTEbHERkNqVzxHY=;
 b=I8t7UAoTktlfuK+Tb4L6j+4iYSfRNsUBcd2xFbV+hG9eXdnykmgwYqVBOmqYfn7nhTP+qIU8o1cszAYlxmF2hYaFtTUHnl67LRtCiD2kXywsZXP8rAcWMqp1AVEvazfSr1FSMRxWU30JN0AlB0LdO2G+XvzsOJm2eo7zrj6HivY=
Received: from IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 16:03:36 +0000
Received: from IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522]) by IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522%5]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 16:03:36 +0000
From: "Hosur, Priya" <Priya.Hosur@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH v2 1/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Thread-Topic: [PATCH v2 1/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
Thread-Index: AQHdKuaN3YW1TZh30kKpneWIFi/B0LacVsYAgAFfVRA=
Date: Fri, 14 Aug 2026 16:03:35 +0000
Message-ID: <IA0PR12MB8895C63A9A009A3F871E4F23F3DA2@IA0PR12MB8895.namprd12.prod.outlook.com>
References: <20260813054220.450509-1-Priya.Hosur@amd.com>
 <20260813054220.450509-2-Priya.Hosur@amd.com>
 <CADnq5_Mge5MoNRyf0Nnynx5M=V2HKN8L-pFXV88GnLzAfOL5dw@mail.gmail.com>
In-Reply-To: <CADnq5_Mge5MoNRyf0Nnynx5M=V2HKN8L-pFXV88GnLzAfOL5dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T15:59:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8895:EE_|DM4PR12MB7575:EE_
x-ms-office365-filtering-correlation-id: a8224adb-f415-41b1-cd39-08defa1d98e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|4143699003|11063799006|10067099003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: i2zCIu433XuknZrvcSBajxI+sOdNeCgMco+/Ln74REzbBv42b/eBNnr6XhwF/nM22bZhwA57e41+ByRK5+/bRwYL7eIaNxlErQ4hAb/7OveKxnxDgjvcDZdVWh0Iikio+Ryr3+SIMZRxgiY5/UXIKelvE6uk5cfLLecqqVS6DjIjVn1tlINv8VvmiNogP5grKlaStWrDtSu6ILigCQYy+fI0NpMFCaHYuxIm5c+OkRscGjNurzNoD3e5JzNIzoZ6sFFN/Dq2Ilfl/5LgR425D/78EIwl4t9HnqnvVQZinvRrQ2m4KNIYfOOmmsJ5dfdEFn46OQn4Zeki99J8etX6bibmL+hZCETAMu7TxKyuWSJM5NJy1XmFat4rIrSFWPk7Nv8hTONN0k5bFx13hcGK1vzVC8FI1MedOuSOcOx/NxFOGtTbCWeqCzI8xG9lQXp4UTU29HzaYNDkFmBCZWJgr04+7HfMbKfK1UocLae/XPPeykrx6/opKARBHFENpdgKBoEA7bExZebE5vituR+BS7R4MVRNFPL34bZzHvzPbORqAw1Kg+4h6kTo0NLk2rTZAi1+VAVhbPe2SA7jZG+N7gAIEemr0cFtUomImeAsPYk8BcsMANzAw3l28I6ELrd3B/iF86IBAXXZKhR8u4P41vvh1ivSUD970Va0ZKZLwFm/R0Zjs55xlOOIwNlozqtMl6femMvBVzeKq/S84xP9miSwEMPmJwu0hQIILdwJCns=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8895.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckduQmFKV0J2UmFWaEUxR0k3QWRsOWxabEJHSmZOQzNIc28wNlV6NUxLbWha?=
 =?utf-8?B?bktGMVRSMXVJdEU3cjJ2OVYydlZaQWxtSWJzUjJERWJHdXlxWTJKZm1wR2dL?=
 =?utf-8?B?VmZvT1Rka0lYTVpESEtQTng5Q0VmWFZtMUN5WnlNNE9WNlcvSm1xcWtFa2hX?=
 =?utf-8?B?MUNlWjlhYVhVdE9YY0VsblUyYUFNUEhkOXlXQ2NUaVd6SFFGZWZBbDlkOGVU?=
 =?utf-8?B?UWw1RGsvbU42bTltTGRBanEwV3JMU0J6NkxKVzBJbk8zRERXUkViaTJpSHdM?=
 =?utf-8?B?aG9xVWZWV3o0T2svR3F4ZXBDZkVHY25yNEJ6Ry8wcDRrS0V5TStGejVUZktS?=
 =?utf-8?B?WjRPR2ZiS285K1JQRTBjM29EVWhyNmpSenFDR0xTeWg0V1ptYzc2ODR6MUU1?=
 =?utf-8?B?QnFCZ3o1Mmk0M2VHZWtyMlVuT0x4dmlPL3g0V1FFUzJ0c3VSR1pLVHdVNWVN?=
 =?utf-8?B?VEozR1RWT0h3SXBPVE1VWlZLMmwxbmJOc0svcGhmMXREWUFkV3RxK3hlME53?=
 =?utf-8?B?emlwbjNwTUtzQVkvWWc5VFhZNkpLWnRoQmZUdUNTU2g5Q05HaFRLdVUvcGIr?=
 =?utf-8?B?STBTU3JWZnV5amk5MTBrNmxZaGkwQTFPL2o1WlMwanErajByM0xWTDJtNXRS?=
 =?utf-8?B?Z2F0UFJXTzk3Rk00WFVQQXhHL0pXeVBMY2dmQlM0V3RhTnBXdTVyZGZ5RUx3?=
 =?utf-8?B?aTlnNVVQZFNGUkRTV3lIMnRCc3FyblVZZGhJN0IyZVB2MS9jakxwZ29xcmhM?=
 =?utf-8?B?aGVYRnlYYmU0TlZkdE51S0xDQy9BTGd2Ynd0NGJ0bmJpL245anUveHk2Q3c4?=
 =?utf-8?B?M2NzczNGeTc2WDFZMjZZeWx0bmlSTVNVTXJ2VVprbVZ2S1gwS3BibmxNcXA3?=
 =?utf-8?B?WXlGUkhXL1BTNU4yWmJTdnU2K080YXdJK0oreVhKUjI4a3NsMlAwdEJmRjNL?=
 =?utf-8?B?T3RFdFpDdFdKcjA4ay9EMlBaZ29LdWEvL0F1a3lVdmRFSGRtMG9iUm5ZSzFn?=
 =?utf-8?B?TVExWk1FSUdsUC9odXBuZkQxaXpkbGFYSk0vZE9lSHl6aWhLM0g2WjZUSWJF?=
 =?utf-8?B?ZlVZbGZBb0JOWHk0NW5GWXJkWkJ0Zk44cU51SE5IUUhmR1lNTlBXSXlHMlNM?=
 =?utf-8?B?THNaRXBHaHFGTnBkQVZqQVYrZmtlOEtBN2RLdTBIYUJUTjdKMWs1aVJQVUZ5?=
 =?utf-8?B?SjR6YnYwNWpPUGZISE1mbVhSNmNFL0xkOXlKS0xmNzd0cTcybHZ0TGxSU1R1?=
 =?utf-8?B?UkowY2VmcklGZnZZNVpXaGZGZVNKK0FTSXIyQkhUT3kwWjFpZFZBRjhiOW4y?=
 =?utf-8?B?UWo2NDc2c3hIdEd5NVRkamZVMm5vTHpHMTFnQ1B3NXhMemVjd3RrWDdPVTVJ?=
 =?utf-8?B?TXV6NHh5K2xqSHFWa0d2a0w1MlB5ckNFMmYyd0YzMkxNNGJVM280dkJEbHNk?=
 =?utf-8?B?QmREYXNtc0JJdU1Za1FqSmtxeUJXQVpmRUd5S01ZUTI2WEhpRnNqaFdXV0RZ?=
 =?utf-8?B?YUdURjg0UzFrWG5ZbWVteitGczQwM0xrL0MyV3BFU3lWRWNFeGhCdXdSNzJR?=
 =?utf-8?B?dnhPWWpJY0hBcEcwRXhDUGJrLzg0QTd1QzN3bTVpajNwR045UWk0U2Y3WjZG?=
 =?utf-8?B?RDMrWDJhTkNGSTJhell4amZKdHhKaHlLQzd2eXllaTNQOXExM1Y1RUxVOWdv?=
 =?utf-8?B?WTh4YTlIbWNXNGhJdGZIZ0lqRUY3S293T0NyWno0emc3Q3lLdzNoY0d0c0Vs?=
 =?utf-8?B?S3BvQTRNdlFUVWxhUEZ2aG1VVW5HWXNxbUhaV211VGFOd2puaEpKbFc0QzVj?=
 =?utf-8?B?VGhieVJoUkNWSTQzM29veU81ajB4cmliM2svZDN5WHRDZDJ1OTlCbEFhcWIy?=
 =?utf-8?B?a1lSMHNwdnNBMDUycVlmREdESTl4TnNoa1pwNkNMVVB0YmdXUVR1dkFCdGs0?=
 =?utf-8?B?SHI2RXdnNnhBbjlFWGVSamVJeXpER0tjVmgrU0lLVzRCSVZwK0J2U3FxZzdM?=
 =?utf-8?B?ZWUyczkxOWR5Tnhia0N3OE12eUxDQm1pdmFnWXUwN0RMbXNCTk1IVkpudEpp?=
 =?utf-8?B?UUdmcVFKWjlFQTBPSkFQK2dGNkdSNjhBZFExZG1lSW4xeUxjbkppS3MrK0tL?=
 =?utf-8?B?aEZudUl4NkRacThkbUR2RVhjZjkwSzFuczhVbkRJcU51Y1RBeHh2ay96WDEy?=
 =?utf-8?B?M25IMVhidmk4MElzT2MxamhLblhyejY0UjI5ZFgwZFI3M0NrYzdPbTZ1ZjlL?=
 =?utf-8?B?d0JUMHp3NjhoaURKTzQ2dnBFOFhHaU1hTEdMQkVKMGRVT2dnbXpPMFpDWjZo?=
 =?utf-8?Q?Gh9JaF90o6dFq7sXh7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8224adb-f415-41b1-cd39-08defa1d98e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 16:03:35.9019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqeFcAlA8GrbI+Y+s3WUc/zSQiZqkZ8khhhKVo1r/YENHxWp3QuHi5xdHqO96eT1zQ345zNNkqLxyN1hDoL+vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
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

QU1EIEdlbmVyYWwNCg0KSGkgQWxleCwNCg0KQ2hlY2tlZCBhbWRncHVfdXNlcnEuYyBhbmQgbWVz
X3VzZXJxX3VubWFwKCkgY2FsbHMgcmVtb3ZlX2h3X3F1ZXVlIHdpdGhvdXQgVExCIGZsdXNoLg0K
DQpJJ2xsIGFkZCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFzaWQoKSBpbiBhbWRncHVfdXNl
cnFfdW5tYXBfaGVscGVyKCkgYW5kIHNlbmQgdjMgYXMgYSAyLXBhdGNoIHNlcmllczoNCg0KUGF0
Y2ggMS8yOiBLRkQgVExCIGZsdXNoIGZpeCAoa2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMpDQpQ
YXRjaCAyLzI6IHVzZXJxIFRMQiBmbHVzaCBmaXggKGFtZGdwdV91c2VycS5jKQ0KDQoNClRoYW5r
cyBhbmQgUmVnYXJkcw0KUHJpeWEgSG9zdXINCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9u
IEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IEZyaWRheSwgQXVndXN0IDE0LCAyMDI2IDEy
OjMzIEFNDQpUbzogSG9zdXIsIFByaXlhIDxQcml5YS5Ib3N1ckBhbWQuY29tPjsgS2hhdHJpLCBT
dW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT47IExhemFyLCBMaWpvIDxM
aWpvLkxhemFyQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+
OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgVmlzaHdha2Fy
bWEsIFByYXRpayA8UHJhdGlrLlZpc2h3YWthcm1hQGFtZC5jb20+OyBHb3BhbGFrcmlzaG5hbiwg
VmVlcmFiYWRocmFuIChWZWVyYSkgPFZlZXJhYmFkaHJhbi5Hb3BhbGFrcmlzaG5hbkBhbWQuY29t
PjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSCB2MiAxLzFdIGRybS9hbWRrZmQ6IEFkZCBUTEIgZmx1c2ggYWZ0ZXIgTUVTIHF1ZXVl
IGV2aWN0aW9uL3N1c3BlbnNpb24NCg0KKyBTdW5pbA0KDQoNCk9uIFRodSwgQXVnIDEzLCAyMDI2
IGF0IDE6NTDigK9BTSBQcml5YSBIb3N1ciA8UHJpeWEuSG9zdXJAYW1kLmNvbT4gd3JvdGU6DQo+
DQo+IE1FUyAoTWljcm8gRW5naW5lIFNjaGVkdWxlcikgZG9lcyBub3QgcGVyZm9ybSBoZWF2eS13
ZWlnaHQgVExCDQo+IGludmFsaWRhdGlvbiBhZnRlciB1bm1hcHBpbmcgcXVldWVzLCB1bmxpa2Ug
SFdTIHdoaWNoIGRvZXMgdGhpcw0KPiBhdXRvbWF0aWNhbGx5LiBUaGlzIGNhdXNlcyBhIHJhY2Ug
Y29uZGl0aW9uIHdoZXJlIGluLWZsaWdodCBETUENCj4gZGVzY3JpcHRvcnMgY2FuIGFjY2VzcyBt
ZW1vcnkgdGhhdCBoYXMgYmVlbiB1bm1hcHBlZCwgbGVhZGluZyB0byBwYWdlDQo+IGZhdWx0cyBh
bmQgR1BVIHF1ZXVlIGhhbmdzIGR1cmluZyBTVk0gcGFnZSBtaWdyYXRpb24uDQo+DQo+IFRoZSBp
c3N1ZSBtYW5pZmVzdHMgYXMgS0ZEU1ZNUmFuZ2VUZXN0Lk11bHRpVGhyZWFkTWlncmF0aW9uVGVz
dC8xDQo+IGZhaWx1cmVzIG9uIGdmeDExNTEgKFJ5emVuIEFJIE1BWCkgd2l0aCBYTkFDSyBtb2Rl
IDEgZW5hYmxlZCAtIHRoZSBHUFUNCj4gY29tcHV0ZSBxdWV1ZSBoYW5ncyB3aXRoIHBhY2tldHMg
c3VibWl0dGVkIGJ1dCBuZXZlciBjb25zdW1lZC4NCj4NCj4gQWRkIGtmZF9mbHVzaF90bGIoKSB3
aXRoIFRMQl9GTFVTSF9IRUFWWVdFSUdIVCBpbiB0d28gTUVTIGNvZGUgcGF0aHM6DQo+IDEuIGV2
aWN0X3Byb2Nlc3NfcXVldWVzX2Nwc2NoKCkgLSBhZnRlciBNRVMgcmVtb3ZlcyBxdWV1ZXMgMi4N
Cj4gc3VzcGVuZF9xdWV1ZXMoKSAtIGFmdGVyIE1FUyBzdXNwZW5kcyBxdWV1ZXMgYW5kIG1lbV9m
ZW5jZSBjb21wbGV0ZXMNCj4NCj4gVGhpcyBlbnN1cmVzIGFsbCBpbi1mbGlnaHQgbWVtb3J5IGFj
Y2Vzc2VzIGZyb20gdW5tYXBwZWQgcXVldWVzIGFyZQ0KPiBmbHVzaGVkIGJlZm9yZSBtZW1vcnkg
aXMgZnJlZWQgb3IgbWlncmF0ZWQuDQoNCkNhbiB5b3UgY2hlY2sgYW1kZ3B1X3VzZXJxLmMgYXMg
d2VsbD8gIEkgc3VzcGVjdCBpdCBuZWVkcyBzb21ldGhpbmcgc2ltaWxhciB3aGVuIHVubWFwcGlu
Zy4NCg0KVGhhbmtzLA0KDQpBbGV4DQoNCj4NCj4gVGVzdGluZyBvbiBnZngxMTUxIHNob3dzIHRo
aXMgcmVkdWNlcyBmYWlsdXJlIHJhdGUgZnJvbSAxMDAlIHRvDQo+IGFwcHJveGltYXRlbHkgNy0x
MCUuIFRoZSByZXNpZHVhbCBmYWlsdXJlcyByZXF1aXJlIGZ1cnRoZXIgaW52ZXN0aWdhdGlvbi4N
Cj4NCj4gQ2hhbmdlLUlkOiBJYTgzZTZhZjdhNjZmZTJiZmY1NmNiNjJjNzQxNzI4ZTlhMTg4ODNl
OA0KPiBTaWduZWQtb2ZmLWJ5OiBQcml5YSBIb3N1ciA8UHJpeWEuSG9zdXJAYW1kLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPg0KPiAt
LS0NCj4gIC4uLi9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMg
ICB8IDEzICsrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+IGluZGV4IGEyMzM4NDU3MTE5My4u
NzFjNjBhNDJjNTgxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiBAQCAtMTQ1MCw2ICsxNDUwLDE0IEBA
IHN0YXRpYyBpbnQgZXZpY3RfcHJvY2Vzc19xdWV1ZXNfY3BzY2goc3RydWN0IGRldmljZV9xdWV1
ZV9tYW5hZ2VyICpkcW0sDQo+ICAgICAgICAgICAgICAgICBkcW1fZXZpY3RfbXFkX2JvKGRxbSwg
cSk7DQo+ICAgICAgICAgfQ0KPg0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogSGVhdnktd2Vp
Z2h0IFRMQiBmbHVzaCBhZnRlciBNRVMgcmVtb3ZlcyBxdWV1ZXMgdG8gZW5zdXJlDQo+ICsgICAg
ICAgICogaW4tZmxpZ2h0IG1lbW9yeSBhY2Nlc3NlcyBjb21wbGV0ZSBiZWZvcmUgbWVtb3J5IGlz
IGZyZWVkL21pZ3JhdGVkLg0KPiArICAgICAgICAqIEhXUyBkb2VzIHRoaXMgYXV0b21hdGljYWxs
eSwgTUVTIGRvZXMgbm90Lg0KPiArICAgICAgICAqLw0KPiArICAgICAgIGlmIChkcW0tPmRldi0+
a2ZkLT5zaGFyZWRfcmVzb3VyY2VzLmVuYWJsZV9tZXMpDQo+ICsgICAgICAgICAgICAgICBrZmRf
Zmx1c2hfdGxiKHBkZCwgVExCX0ZMVVNIX0hFQVZZV0VJR0hUKTsNCj4gKw0KPiAgICAgICAgIGlm
ICghZHFtLT5kZXYtPmtmZC0+c2hhcmVkX3Jlc291cmNlcy5lbmFibGVfbWVzKSB7DQo+ICAgICAg
ICAgICAgICAgICBwZGQtPmxhc3RfZXZpY3RfdGltZXN0YW1wID0gZ2V0X2ppZmZpZXNfNjQoKTsN
Cj4gICAgICAgICAgICAgICAgIHJldHZhbCA9IGV4ZWN1dGVfcXVldWVzX2Nwc2NoKGRxbSwgQEAg
LTM3MzYsOCArMzc0NCwxMQ0KPiBAQCBpbnQgc3VzcGVuZF9xdWV1ZXMoc3RydWN0IGtmZF9wcm9j
ZXNzICpwLA0KPiAgICAgICAgICAgICAgICAgaWYgKCFwZXJfZGV2aWNlX3N1c3BlbmRlZCkgew0K
PiAgICAgICAgICAgICAgICAgICAgICAgICBkcW1fdW5sb2NrKGRxbSk7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIG11dGV4X3VubG9jaygmcC0+ZXZlbnRfbXV0ZXgpOw0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICBpZiAodG90YWxfc3VzcGVuZGVkKQ0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBpZiAodG90YWxfc3VzcGVuZGVkKSB7DQo+DQo+IGFtZGdwdV9hbWRrZmRfZGVidWdfbWVt
X2ZlbmNlKGRxbS0+ZGV2LT5hZGV2KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAvKiBIZWF2eS13ZWlnaHQgVExCIGZsdXNoIGFmdGVyIE1FUyBzdXNwZW5kcyBxdWV1ZXMgKi8N
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBrZmRfZmx1c2hfdGxiKHBkZCwgVExC
X0ZMVVNIX0hFQVZZV0VJR0hUKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gICAgICAgICAgICAgICAgIH0NCj4NCj4g
LS0NCj4gMi40My4wDQo+DQo=
