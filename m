Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29E1C43217
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 12:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D882F10E3BB;
	Tue, 15 Nov 2022 12:02:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E3A10E3B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 12:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muF4e/FQN9oxgJx7ZxDc5v8ZSH6zSPPHBIVrouZIDuaphJjrl6ME0BM76Vp5hxTE+cdODz6OM00bfzF5JRPwOmhslcriw2eUUXlA1CjNN682smyrMzSKnPAu4CfupstRywuvFWtlNn4w3LGqBmWH33SVJw5H8QLvsI7EGr77gM3AWG6O9X/hV6DgTBDApTFqsLjLurNIACKiMSpHkDMcc2vDP8XSDpNNKWtbKyvGydTuF+DOfK8ZoyUWllmjxbofaef8QprEiyGqa0CoGsve6ejJjhWoekR74L8IPDePYhCkeDMFmGfsKq0OODX/CUklSr4r2V+/BU6G9vhIgxbKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6Yyk6phZWf8CbSn7ETEfdRIsMq5HXKFFi5jIKRXs+M=;
 b=T9IXkFQd5s2zbmAjgTlkGf1nw69cKQdFnHLi+bG17g95/U/UHmltVaAle09a6bRNk+wrqYOn0UxxuAMvYyEwVjam0lvzyHC1yeErSd1iThsoWGyWS7beJHBL7e1Zg7+iEr07Cdk9Wriw1kZ+MoO9cbWB+ysUcxMXFEMV1h+5szbd8iK7VV73ag/GPzyPctXai0gLVZhsOf6KrqaqzcDDLOQNkzpdc8gmDqknHzxNVJGzMJG/Sff7fsXxDejRqLe3suQWRrV8+nf1GEb6oFciR1BHC20YCmNbQQD18YjgX14vZrCHd+7XNxFqwMBB/EpqsrZ44WtCJz2ZayEoe+kYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6Yyk6phZWf8CbSn7ETEfdRIsMq5HXKFFi5jIKRXs+M=;
 b=sYfVr6ptoGDBpUCKgcNas2mghx0cvq60BXQuVZvwPHbkTVjJUYPo3heEqu3DT9/j1+ipBLsglIyO7ACg1TX6Q3HWmKOgxOn2NC2CMGJVTI320iee4SeIo1eJxn1o5MAjd1css/yU1T448quHQy1mSoV2Z9Km99vv73X1ZKttl8s=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.16; Tue, 15 Nov 2022 12:02:37 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8263:6a57:7f81:faff]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8263:6a57:7f81:faff%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 12:02:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: disable BACO support on more cards
Thread-Topic: [PATCH] drm/amdgpu: disable BACO support on more cards
Thread-Index: AQHY9auPp29/L4XcOUeYOBRQeR2GDq4529YAgAYMgzA=
Date: Tue, 15 Nov 2022 12:02:37 +0000
Message-ID: <DM5PR12MB2469390B23E80275541B7108F1049@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221111085641.2264671-1-guchun.chen@amd.com>
 <CADnq5_NU-zxf-3Xp-b5ug04fcoO1+43r03AJ0mTxiVKiPv1yOQ@mail.gmail.com>
In-Reply-To: <CADnq5_NU-zxf-3Xp-b5ug04fcoO1+43r03AJ0mTxiVKiPv1yOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CY8PR12MB7146:EE_
x-ms-office365-filtering-correlation-id: 39b0cd41-3f19-4096-2ee4-08dac7014a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /GXC1wYvpqY1upFHZkLNHqBJMXqTNPDSvD/hvx1oDF9Ir85bcTdp3nV1nbngczOuwJy3O9e3JmLUl62Uq8DC/XQdrDn/VUQSlukkSDbfP7mQuwJhnVw1HQqC91Rt45B3flvxwz9/4Nfq7VdcmzieRf1oGCUGLvpxljBRubwL0WQc8oSU8JygzYf39YocibsWw0udEmWcy6MSEY7BF+6Ogt90Udiqf4YIuwUM/3Tc8kSgfMKVim8Ylyiv1rHuCMB5wxXw5LN4cOL1HY14MkikudbK+KBvamz6R+k7F+lNllyVGZskewXPIEQw8f0pl8WDTPQOSr7HDx5SaY2OYocBzPV/9vyJGS66LdMoWeHagWh9/ivgLLVFgTYrHClnjSwAQbrPGyEEEn8+RugAqEnh3RZ4EOvGYlaxqNJ5lZvroZErxgVlqSwyJ40uSRobLH9FJfCbBoC5Ha9xBR8OD38J6+XeulQJkvBC9wyZKfq/2Oel+2Hs3zYGhWsGbaKgkP2fyn0JG1T+0H29ZDC5lUN17IS/PwB/sPWBZ913NL0KJilcKrCxwdaNe3G7kBn4Eern9nCMNZSBiG9JVfbR+H4ZcepuJTmG20X7NWA8KUSsaOEITt/ikH/ZPDs85sDLgjtxI0YBOPHVFvfPXIL/XAE/JSH1uCsSRaYglC3FNf3t//KHH9x7rrLPi8uCfz1QbGEzMKLmUxJIz69j7p62pa+Rzciiu0q7INlsr7UYfRKRoH7JPg3cs20yqzWa0N7QaxAbYjpSOJHScoYQJyqDETz/Fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(8676002)(33656002)(8936002)(38070700005)(41300700001)(2906002)(83380400001)(54906003)(64756008)(38100700002)(86362001)(6916009)(66946007)(478600001)(186003)(71200400001)(4326008)(76116006)(53546011)(122000001)(316002)(52536014)(5660300002)(55016003)(26005)(6506007)(9686003)(66446008)(7696005)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGx5Z2tid2dOOU1Sd0kwdllTdHJkMXVRWGk2eXZFZnFWNkRyUmxpMCt3S2li?=
 =?utf-8?B?ZysrZzdweHdEU2VCNmRydzVQRCtndnZrUVlyVjF5V3ozUnFzZkluaE81SXEr?=
 =?utf-8?B?dHR5b3hhMzYwN3ZZTllwVGVFZm9yMlJIT1NDUFdoaDAvR3JFZkZYQVBhWVM1?=
 =?utf-8?B?dGJtNUxiV09xSHQxQ3Nnc0JaTll1cFhjbnZGWEJIL3g5bzc1TVlRak9SR2lm?=
 =?utf-8?B?dW0wZzlTVERnMm93OEFCUmtFcE12YjQ5aThEUHB3R3YvbkdVYTBzT29weGRY?=
 =?utf-8?B?ZG5ab1I1M08za3FURGRxR1hKR083aG90RHhwV2tVMXF5YSs0eXd3L2xQVG45?=
 =?utf-8?B?TkIvbHZCVTdmeXlpbDBvdkdJSFZ1NElvWGgxYU5rRGJrTmYxdk14dHpVYjZr?=
 =?utf-8?B?eWh4VE5PZllTeURnNUVBcjFPV1RhMlBiVW16RWtCY1pGN2FOenlKclR2UVVj?=
 =?utf-8?B?OTFEd21kblpIVlNWcEVVS2pBUE5EVzdwTUh1bi9OY2xiV2hHZnRLQ2NzOEdk?=
 =?utf-8?B?eHdQU0ZPeitLdkdDVHlyUmpLNG5ZUnFDd3hEQ2xRd1VCVHJDeGFUMlZVUXdK?=
 =?utf-8?B?dFJ3a0ZEcFpBSEF3NThKMXBWT1dBelRrUldBTHpnT21nY3BGbk9OdzRtTURN?=
 =?utf-8?B?NksrTjZqcWN0ZDl1UnNIS2VNcXp4bTlpYWt6MVRSeHdxYmxodE5SV0w4ZTZO?=
 =?utf-8?B?amRiMlhJMEh2MTRPbVp5L1Z3MThLUHFNSkhPQ0srWUNZRkc3MnZ5OFlrWkNi?=
 =?utf-8?B?N01HRTlwU3I3alhLOFRJTUpRcklaRjZ2YTNYeW1VQ2dvMWg2RVN5L0F3UTJ6?=
 =?utf-8?B?MXNPR0dhd0hRQ2dNUWNVT0E2UmJtb1ozQVB1YXRsb04xZzcwRGVaUDNNUU1Q?=
 =?utf-8?B?cXZFaHpmRE5ydUR4Q1BnRGZFTi9DSitBZUVnakt5YkhYekhBOVE1OFlxZzdM?=
 =?utf-8?B?bmpjL1l5L3pzbUNDMXRBVGtsbll6bjZ3aUxUczFFVWVWdzJreXA1VnBTeElG?=
 =?utf-8?B?TTI0UGxYV1JvUW9SNzI3Rkp2NVQ1Ym5CRlJnYnVCRVFnRm9tN2l6MGZ4Z3VL?=
 =?utf-8?B?dVgxcWZWNVk1SFVncW9YdGtDWkE2MXdaNUg4cUJtN0FoS2MrbUdXaEhMMXpT?=
 =?utf-8?B?SUdmTFAzTmJISEFMV1lhaUVRc3dxRU93UjlQM3B0MEF0c28zVm0yQWhRR2Fa?=
 =?utf-8?B?QkhWTCsrS3lzTG1hc0RZRVF1T3JvRkV2ekNzUkRpRGh0UFM4U2tZT2U2cTV5?=
 =?utf-8?B?ZEpzS2lnUWsxZnpzcTh4cnkvRWV3TkwxL0E2MjNoRnBHQkJlelFoaWw0em1B?=
 =?utf-8?B?RUcyYUhNZ2dxY2F2SUtCK3BSaTNxWmw2OWE3aDJPZnhKS1RCakMvWDYyN2lG?=
 =?utf-8?B?TGlROUxpWmhHakpuMXVwa01Wdkl0dTBIVllOeVJnZjYyOGhzNUF2Q3VjbDV3?=
 =?utf-8?B?OFFwSzZrVm91SGlGeDBSRGNORzY0ZGluTVF2V08weDhKVWhXVms1aUs3b0sz?=
 =?utf-8?B?Q1lhMmorU3puOFl6Z1N5cXB0bkhTcEp1T3ZPTlhwMUlGV1dUVFIxUkZTRlRo?=
 =?utf-8?B?YTlJUkdobnZ6UjRaT29HbzZURy9pclhybG5PcHhFemV5RDZaWThPWjVtZGNX?=
 =?utf-8?B?aUtNNWczUlJFUXdTNjlEd2hjYjA2TGx1a0w1M285ZXhrWmc1Um82SkdIRUJk?=
 =?utf-8?B?eUdsZWYxSHA5QWlUMVp5bGdMb3FTbGE0Yk5aM2U5Yk13cU81Y25UZFRDVy9z?=
 =?utf-8?B?dUdxamJKNzFHVFl6VGdtVnVWN0RiallRWnZZcDVHWHF5SVVLMzlqUk81ZTR4?=
 =?utf-8?B?bXFkalhxVDRCM3JBbDRTOWtXTGs4R2Z2Qk9wVkY4ZzNpR2E2UWh5aGpaTkFw?=
 =?utf-8?B?S1lMamRqRnp3aHRkVSsyZkpyaWJ3QjZlU3RSQWNodkt3NFVXZ21iRzEvOTRG?=
 =?utf-8?B?YU52M01scm13UktWTGtaY0RvS3oxR2hYVDZsd21oWDBPZkRQV2kwWXdjbS9P?=
 =?utf-8?B?QkZLckRkc2JZdkVpdUM2ZEl2M0RRNkNmZGhJckp5RGE2Z2wxSU8zTkRCcUI4?=
 =?utf-8?B?S3d5MU5oYWFIeHZXN2ptOVdsUFNmYjhuRWphczJpcnBvbFlVR3Joa3RWdG8w?=
 =?utf-8?Q?gjVo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b0cd41-3f19-4096-2ee4-08dac7014a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 12:02:37.6142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xp//+OMxm4HAX82rByvdVQgNEHorh9vRCZsUcgApdxayuSyh0JKB7TdCgIhzDranb7PDy6X/e7D0cKp5S2ObXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVzLCBBbGV4LCBJIGFtIHRyeWluZyB0byBnZXQgdGhlIHJvb3QgY2F1c2UgZm9yIHRoaXMuDQoN
ClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFs
ZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiANClNlbnQ6IEZyaWRheSwgTm92ZW1i
ZXIgMTEsIDIwMjIgMTE6MzggUE0NClRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5j
b20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpo
YW5nQGFtZC5jb20+OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgUXVhbiwgRXZh
biA8RXZhbi5RdWFuQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBk
aXNhYmxlIEJBQ08gc3VwcG9ydCBvbiBtb3JlIGNhcmRzDQoNCk9uIEZyaSwgTm92IDExLCAyMDIy
IGF0IDM6NTcgQU0gR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+IHdyb3RlOg0KPg0K
PiBPdGhlcndpc2UsIHNvbWUgdW5leHBlY3RlZCBQQ0lFIEFFUiBlcnJvcnMgd2lsbCBiZSBvYnNl
cnZlZCBpbiBydW50aW1lIA0KPiBzdXNwZW5kL3Jlc3VtZSBjeWNsZS4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQoNClBsZWFzZSBtYWtlIHN1
cmUgd2UgdHJ5IGFuZCByb290IGNhdXNlIHRoaXMuICBJIHdvdWxkIGhhdGUgdG8gaGF2ZSB0byBs
ZWF2ZSB0aGlzIGluIHBsYWNlIGZvciBhIGxvbmcgdGltZS4NCkFja2VkLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jIHwgNCArKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jIA0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMNCj4g
aW5kZXggNjIxMmZkMjcwODU3Li42OTdlOThhMGEyMGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zaWVubmFfY2ljaGxpZF9wcHQuYw0K
PiBAQCAtMzc5LDYgKzM3OSwxMCBAQCBzdGF0aWMgdm9pZCBzaWVubmFfY2ljaGxpZF9jaGVja19i
eGNvX3N1cHBvcnQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQo+ICAgICAgICAgICAgICAgICAg
ICAgKChhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHg3M0JGKSAmJg0KPiAgICAgICAgICAgICAgICAg
ICAgIChhZGV2LT5wZGV2LT5yZXZpc2lvbiA9PSAweENGKSkgfHwNCj4gICAgICAgICAgICAgICAg
ICAgICAoKGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDc0MjIpICYmDQo+ICsgICAgICAgICAgICAg
ICAgICAgKGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4MDApKSB8fA0KPiArICAgICAgICAgICAg
ICAgICAgICgoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NzNBMykgJiYNCj4gKyAgICAgICAgICAg
ICAgICAgICAoYWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHgwMCkpIHx8DQo+ICsgICAgICAgICAg
ICAgICAgICAgKChhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHg3M0UzKSAmJg0KPiAgICAgICAgICAg
ICAgICAgICAgIChhZGV2LT5wZGV2LT5yZXZpc2lvbiA9PSAweDAwKSkpDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHNtdV9iYWNvLT5wbGF0Zm9ybV9zdXBwb3J0ID0gZmFsc2U7DQo+DQo+IC0t
DQo+IDIuMjUuMQ0KPg0K
