Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CAAC61DB4
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 10:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5664F10E1C0;
	Tue, 25 Aug 2026 10:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SBmKn89T";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC0C10E1C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 10:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yb6NsyHm3uVCcnlB+W07ly+9cojwPsSc62ImH3qRn85j+YkuyyieUbOZBRBYep5KcTp6Uayf/6FNJ8v/XQ4u8/N3awa/IaPyLepjKKLIt7kGGf/3lfMyQnf4/6Sk1wKZ2fbNB/C6PjojgezKOQwhrfBs9J7mwMlBoOQQiu8WdTrOJCBhdP8rx4EHPWVn19Q7Cobf9yb2NoIzDKoxvF8F0LPXy0PnR3n+GJNaONvdq6UTlGyV0QtM5LJAI3WixVGO7Q7l8bOdsUKBcI/Ywe/aZ2K9JSfQr7oB/hm7JnQnDSH/xWAnRNzAS0IpkMlMo/ZmlVENDH60PzNwVA5h9bHvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfDdlKcjvZqFnNbFntic8juPT/k6gAV2T8Nztnli/Sw=;
 b=oZ9X3v5GD1IswJ8kBJ6AbNJLMqhbM7P/oW+bIh4QikDB440uil4znm+bpbn3XNTNQrYSw4vBENWnqOlvqEdk6Fkm/zzl6b/nJc7FAtXRTy0nLoc2POHcTc8FpNXLNIwzglw+4EDODlPYiZp4ds6qQrjKRSnNMvZrkXztzYsdwzOmI2AJEmRPbEqP8I6njR41PcilY+1oYtncq7+YfXLZTbd+4d3KiYn/GRw7t6ODp05nsuHeAAyNZTpqQtrgO9KByQMbgdvq8VS1kZoZcUE8ZzaWIgtINBJ5CKbI4WfQwpz+b3rspz57EVvPuOaWuWziRgVi1Uba8bGRGZ1Ik3D7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfDdlKcjvZqFnNbFntic8juPT/k6gAV2T8Nztnli/Sw=;
 b=SBmKn89T84dpXAG92nPn25+/zHxxpdK/Pg2xffhbNroDpwr7uEbYmdfOUMV2Nsa0QApTycwyd8CSVJvlwlWyx9X4kO+pLzxE2MkijLzv400oLPjj4JKLNgVCOwF2WhZOXXwpj6PmXfZCdHbI5ulCvDp8N2b6Cu5XV6HC3yXX5rs=
Received: from IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 25 Aug
 2026 10:36:10 +0000
Received: from IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522]) by IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 10:36:09 +0000
From: "Hosur, Priya" <Priya.Hosur@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
Thread-Index: AQHdLAim0YA7X1/aUkizBVDzj4MR0bas30oAgAGDxACAAD/DgA==
Date: Tue, 25 Aug 2026 10:36:09 +0000
Message-ID: <IA0PR12MB8895E4C270F9794C41BD84F4F3AF2@IA0PR12MB8895.namprd12.prod.outlook.com>
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
 <20260814161841.5906-3-Priya.Hosur@amd.com>
 <39ce25a7-c20b-4513-9ac1-3b636e3af6a5@amd.com>
 <PH7PR12MB779458D6EFD35B99A32C0A3193AF2@PH7PR12MB7794.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB779458D6EFD35B99A32C0A3193AF2@PH7PR12MB7794.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T06:45:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8895:EE_|DM6PR12MB4075:EE_
x-ms-office365-filtering-correlation-id: 21178087-775a-4f1b-cefd-08df0294ad69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|921020|56012099006|10067099003|4143699003|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info: qh8YDpFIbDUuROc0qNcHaEbKjPI7L8xisYXngKb9/42x+sWXA9jvxDTNQE5OOQHVII09A2Jz2WNXVVWN6MwnuOs7Bgbmlz6Y1Ac6lumzOzSc8SctO1Ps7BGyk5lFf/zUJYX5XM8HecD9qIbbbl8cJQQte4XOPbAhwKNufFnyynTxnvaC0GoEXozcEozEAN2w1ngjDmN67oXncHIP6L0vIHnFpE+PHGQaBF/BJsXrdMrVwB43jqy3mTXLrilVbDcjdBPq2SrEfS752TjO6yVgutofPUTlEbE3eTXw5AY0ifCYaNDhz9FtnlZDLfE/9C3r1K9R+DlDYQ/bCvuAmD5PsdVpPnmRQHiRXEO//ASce/3NVBduP2Vx+S1oSwz9MykZ+bo7veCBFSHo+CgMb56t3LDYtjpNG4SXNY33RxxSWf5MBPqWALNl3FZeoh9m5HzGanQvdeMkmzvHSvJq2GwOc0/mu7qXpKhL+IJN2LmIdPIVrm8BQWndzYzy8nAqxzK12p7frR4h0rEXK2403JiX3LH8nxnHS3EEHUL3zaKCwMNB16q708AmjcBtIkPCwM5LBNUPtgQq7xGTEL/1oDXVo4fS0tgTPWOo0kJ+Di4ze/t/50XUbvmcQ8U+5dVsyCnXwjzuqqlPZdCSmefq8yvZqOBzchdytRonOXn949fqwm/Soiq6r1eNV7Ad3DhfoeEufj4IJEAqXrOTFLA17UXLKkVRl8X8fsk9POCVp4cf3ZT9JWahwLVFrqi9gcJNdxmM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8895.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(921020)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WURDNEU3WE1IaUdtaVNpWk42dHlzOFhkVEtvV2tJT2l0MEtrOUJEQXRDWEdK?=
 =?utf-8?B?U1A3alJDclFBYUF3c1ZDbUtTeW13NE51R3pDR0M2L3kzenNOUEhxMWdTbHc2?=
 =?utf-8?B?T3FpS2hCVjczRld2UWJISm9GbFdnVmxUc3Z1WG5wZmlEVERMSTBRTVRhQ3ZF?=
 =?utf-8?B?UXNNSkZSd2ZhOWgxNFFZeG4rNTJYZjN5dlJCdTRybGR2Y3BHZ1BUOHIrQUdu?=
 =?utf-8?B?R3pwS0FXVU5SYzg5b0U5Q2txSnlhRWFBQUk0WjFkSDhzb29hb3BEQ29oeFBR?=
 =?utf-8?B?RnVFcDl2NFdLS3NHV05BV2FMNVpFKzlMQVU5TTNhM0E2UmZGYW9jTU1SdDU2?=
 =?utf-8?B?TkN6SUliTmhzYWV6ZG9yckFhaW5KK0F6Q3JYWnZ1d3kwODRIOUYrSkVlK0N0?=
 =?utf-8?B?Yi9PeExwRUlWMUJKWkdBUlFUY2tQVkwvMWNxN1F2clErVWRsdG9NM3hSTEtY?=
 =?utf-8?B?ajhPbnl3YXRNWmFNT1JGOGNBMldUTC9GREFxMDNQdnFaQm4wbSs2VFBoN2k4?=
 =?utf-8?B?NEZ1RjBnWW0rVkJhaUZORVNaamFqZUNWUUUwWHRieDFVazBIM3hTc3Z1R1Q2?=
 =?utf-8?B?cFVuNzZmaGJlL0o2bVZsZS9SSDQ1L3p6ZURuZEgwZ1VxbkJHb1FLa055dlZy?=
 =?utf-8?B?S25XMDViYktoaDBTSnhWU2JmOUxMRkJWbURrNUVIMW4zQUY5MXZqektvNGpI?=
 =?utf-8?B?dXRyTWlUb2d2N2QrNVh0ZEdvelZURWk0dWhQYk8wcENBU1oxN3dzblRybEFE?=
 =?utf-8?B?czlwVWE1YWhOYlhQNWhjT2R0Y1ZFekgwV3lnYWZjdGpUdldZT3dSeEh2WGVH?=
 =?utf-8?B?ZmxGdTEyaTJTYU8xTEhpbE81QlpmZDArNEdZWXRZc2JWNlZyempmU1pYczNR?=
 =?utf-8?B?aEIzQnB3Q1dOZmF1MDZBWFo3Mk1vSWpYOWN5ZkszL0JiY1c4RjhLM2ZubXhv?=
 =?utf-8?B?YW5CRTlmdzRGRlM3dFRzaDd4emxUaFdOWGxoek1JR21Mc2lYcm41OGlESFJ1?=
 =?utf-8?B?KzZqR2k3cENJdnIxRUxnQThPWE4yd1FiVk8ycmJTSW5CaFlDYjh3MnZKWE5K?=
 =?utf-8?B?N1BwUnMveTIzaGovVDliMVhwQklkcGVmNTR3VGkzVkVKY3Q0NDM4M1l6cmxs?=
 =?utf-8?B?SHIxRHNDcXF1RDJtaHR0VTh0YU02OVRnK2xlRDNNQm0zb0VTV0NUTFI4bHFM?=
 =?utf-8?B?eGVLc2kyUUpVVzdxM2E2SHoxbS9nRk9zV3ZjWmdleVV2dGF0TlE2bkZmYVB1?=
 =?utf-8?B?WXAwYThYUVNzVzV5QVdZRStnZ2w0MU5Ha0QzcVNydGNUUkd4V3N5UEJIWWxM?=
 =?utf-8?B?d1N3WnhuaFdCL0lQWmFoQytycGtzL3phdkhsYVBRVmNRYUJSWU9oQU5QbWg2?=
 =?utf-8?B?T1Z6Y2VzWUlmU3lsL0o4bGQ1ZUlUbGdPbUMzbXhneVBLQ29vMUY0ckxLeDJw?=
 =?utf-8?B?S3JXQnl0QnZhSHpxL2hUeis4N0o5NEtyODFidmpsTnZCM1N3clNHclh4NGI0?=
 =?utf-8?B?S3ZoOG40eUpta0Y5ZERsRi85RXpWdUFuaTBuNU40dWJmcGVycUg0QXNzMmtD?=
 =?utf-8?B?ZnBpUEd4VUpjaVptdEZKM3Zjd2JPS3BiRXM2OE85WVZaWTM5SFIrV1NVZDZs?=
 =?utf-8?B?bzMvMkFwM1U4K01BaXlzaGZBNis2VG5CYUcxV2J0K241NnFQQU45YytrUThq?=
 =?utf-8?B?N3FzbVlxcU9FRkgvVVpBWE93d0c4VVRxWDhRYlZQSWxpZHoxWU9pWlpjSlBZ?=
 =?utf-8?B?QS8yd0lGQ243cktNd3hJNnZCQXI2QlJBYnJyaXIyZENiSXhGNDByY0NKYWdX?=
 =?utf-8?B?RWNuemoxaW50dUp3OUx0Y3FrUzV6SnFoalVrLzh4OWJiNDZMNXZJRTVEd3hZ?=
 =?utf-8?B?a0wwS0JtVE1hampLNkJab1g0MTQwRGFTTHNTM0hKRUNnWGZZWGhna012QzJL?=
 =?utf-8?B?K0RvYkxlcGIvak5hRjN5WFlydXJxVG0yRWZIYUZ0NjAyK2lhakRobEhtQWp3?=
 =?utf-8?B?YWhsSG1ETVorbWlOdzJkd0ltSGIvcDRoWkh5QlZHSEQ1NTN6Vng3VUhzdWM4?=
 =?utf-8?B?OVpXT1VzWGNlMGxkWmNnKzQzWU5PdE8xd2pSSnVoeW5YeHBka0t3eVQ1TjBV?=
 =?utf-8?B?NmN5SEY2M1RtUXd0MHJqSFRnM1B5aUdrMG5sT0EyNHpXVVhtMnBPTXRtbjRC?=
 =?utf-8?B?SWRSM1NoWi9QNDVTNWpWWVpGK1E5QmFDcktmMXBIclNPV05DM2ZTVlBuajJv?=
 =?utf-8?B?OW1SSW1yT2lNWHRlM3UwRnJzY2dkeUNFSUsvNFpVWkdSWHFGRDFmSnZlRkFm?=
 =?utf-8?Q?L+SNGF1fdNgw/ArKSu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21178087-775a-4f1b-cefd-08df0294ad69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 10:36:09.7160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzn64GU4/LRjotHeoD0FWY67qwAgzxPEg6Ui1fHaKKuTysnwi2tstqEDENzwQK3eiisItuJDFG6SM2O9CvmVQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

QU1EIEdlbmVyYWwNCg0KSGkgYWxsLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjayBhbmQgZm9y
IHRlc3RpbmcgdGhpcyBkdXJpbmcgc3VzcGVuZCDigJQgc2luY2UgaXQgZG9lc24ndCByZXNvbHZl
IHRoZSBUTEIgaW52YWxpZGF0aW9uIGlzc3VlIHRoZXJlIGVpdGhlciwgdGhpcyBjbGVhcmx5IG5l
ZWRzIGRlZXBlciBhbmFseXNpcy4gRm9yIG5vdywgSSdsbCBwaWNrIHBhdGNoIDEgKHRoZSBLRkQt
cmVsYXRlZCBmaXgpIG9ubHkgYW5kIGRyb3AgcGF0Y2ggMiAodGhpcyBhbWRncHVfdXNlcnEuYyBU
TEIgZmx1c2gpLg0KDQpUaGFua3MsDQpQcml5YQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+DQpTZW50OiBUdWVz
ZGF5LCBBdWd1c3QgMjUsIDIwMjYgMTI6MTcgUE0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgSG9zdXIsIFByaXlhIDxQcml5YS5Ib3N1ckBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT47IExpdSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT47IExhemFyLCBMaWpv
IDxMaWpvLkxhemFyQGFtZC5jb20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2ll
bGxvQGFtZC5jb20+DQpDYzogVmlzaHdha2FybWEsIFByYXRpayA8UHJhdGlrLlZpc2h3YWthcm1h
QGFtZC5jb20+OyBHb3BhbGFrcmlzaG5hbiwgVmVlcmFiYWRocmFuIChWZWVyYSkgPFZlZXJhYmFk
aHJhbi5Hb3BhbGFrcmlzaG5hbkBhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSCB2MyAyLzJd
IGRybS9hbWRncHU6IEFkZCBUTEIgZmx1c2ggYWZ0ZXIgTUVTIHVzZXIgcXVldWUgdW5tYXANCg0K
QU1EIEdlbmVyYWwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBNb25kYXksIEF1Z3Vz
dCAyNCwgMjAyNiAxOjA5IFBNDQpUbzogSG9zdXIsIFByaXlhIDxQcml5YS5Ib3N1ckBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQu
Y29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgTGl1LCBTaGFv
eXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT47IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCkNjOiBW
aXNod2FrYXJtYSwgUHJhdGlrIDxQcmF0aWsuVmlzaHdha2FybWFAYW1kLmNvbT47IEdvcGFsYWty
aXNobmFuLCBWZWVyYWJhZGhyYW4gKFZlZXJhKSA8VmVlcmFiYWRocmFuLkdvcGFsYWtyaXNobmFu
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gZHJtL2FtZGdwdTogQWRkIFRM
QiBmbHVzaCBhZnRlciBNRVMgdXNlciBxdWV1ZSB1bm1hcA0KDQpPbiA4LzE0LzI2IDE4OjE4LCBQ
cml5YSBIb3N1ciB3cm90ZToNCj4gU2ltaWxhciB0byB0aGUgS0ZEIGZpeCwgTUVTIGRvZXMgbm90
IHBlcmZvcm0gaGVhdnktd2VpZ2h0IFRMQg0KPiBpbnZhbGlkYXRpb24gYWZ0ZXIgdW5tYXBwaW5n
IHVzZXIgcXVldWVzLiBBZGQNCj4gYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiX3Bhc2lkKCkgYWZ0
ZXIgTUVTIHVubWFwIHN1Y2NlZWRzIGluDQo+IGFtZGdwdV91c2VycV91bm1hcF9oZWxwZXIoKSB0
byBlbnN1cmUgaW4tZmxpZ2h0IG1lbW9yeSBhY2Nlc3Nlcw0KPiBjb21wbGV0ZSBiZWZvcmUgbWVt
b3J5IGlzIGZyZWVkIG9yIG1pZ3JhdGVkLg0KPg0KPiBDaGFuZ2UtSWQ6IEk5NGZlMmM4NDU0Nzcy
M2I2YjczODE2Y2U4ZDcyN2E1NGJkNzczYTZhDQo+IFNpZ25lZC1vZmYtYnk6IFByaXlhIEhvc3Vy
IDxQcml5YS5Ib3N1ckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV91c2VycS5jIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJx
LmMNCj4gaW5kZXggNmQzZWQ1NWU5YWI0Li45ZmNmMTVkNjliN2IgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+IEBAIC0zNzUsNiArMzc1LDEyIEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X3VzZXJxX3VubWFwX2hlbHBlcihzdHJ1Y3QgYW1kZ3B1X3VzZXJt
b2RlX3F1ZXVlICpxdWV1ZSkNCj4gICAgICAgICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAg
ICAgICAgICAgICAgdHJhY2VfYW1kZ3B1X3VzZXJxX3N0YXRlX2NoYW5nZWQocXVldWUsIEFNREdQ
VV9VU0VSUV9TVEFURV9VTk1BUFBFRCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZS0+
c3RhdGUgPSBBTURHUFVfVVNFUlFfU1RBVEVfVU5NQVBQRUQ7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAvKg0KPiArICAgICAgICAgICAgICAgICAgICAgICogSGVhdnktd2VpZ2h0IFRMQiBmbHVz
aCBhZnRlciBNRVMgdW5tYXBzIHF1ZXVlIHRvIGVuc3VyZQ0KPiArICAgICAgICAgICAgICAgICAg
ICAgICogaW4tZmxpZ2h0IG1lbW9yeSBhY2Nlc3NlcyBjb21wbGV0ZSBiZWZvcmUgbWVtb3J5IGlz
IGZyZWVkL21pZ3JhdGVkLg0KPiArICAgICAgICAgICAgICAgICAgICAgICogTUVTIGRvZXMgbm90
IGRvIHRoaXMgYXV0b21hdGljYWxseSB1bmxpa2UgSFdTLg0KPiArICAgICAgICAgICAgICAgICAg
ICAgICovDQo+ICsgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJf
cGFzaWQoYWRldiwNCj4gK3F1ZXVlLT52bS0+cGFzaWQsIDIsIHRydWUsIDApOw0KDQpBYnNvbHV0
ZWx5IGNsZWFyIE5BSyB0byB0aGlzLg0KDQpUaGUgTUVTICptdXN0KiBndWFyYW50ZWUgdGhhdCBp
biBmbGlnaHQgbWVtb3J5IGFjY2Vzc2VzIGFyZSBjb21wbGV0ZWQgYmVmb3JlIGl0IHVubWFwcyB0
aGUgcXVldWUgb3Igb3RoZXJ3aXNlIHdlIHJ1biBpbnRvIG1hc3NpdmUgcHJvYmxlbXMuDQoNCkZs
dXNoaW5nIG91dCBhbnkgVk0gY2hhbmdlcyBieSBpbnZhbGlkYXRpbmcgdGhlIFRMQiBkb2Vzbid0
IGNoYW5nZSBhbnl0aGluZyBvbiB0aGF0Lg0KDQpJIHRyaWVkIHRoaXMgY2hhbmdlIGR1cmluZyBz
dXNwZW5kIGJ1dCBpdCBkaW50IGhlbHAgdGhlIGNhc2Ugb2YgdGxiIGludmFsaWRhdGlvbiBpc3N1
ZXMgdGhhdCB3ZSBhcmUgZmFjaW5nLg0KDQpyZWdhcmRzDQpTdW5pbCBLaGF0cmkNCg0KUmVnYXJk
cywNCkNocmlzdGlhbi4NCg0KPiAgICAgICAgICAgICAgIH0NCj4gICAgICAgfQ0KPg0KDQoNCg==
