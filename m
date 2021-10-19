Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45DAC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DBC610D0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71DBC610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235C86E857;
	Tue, 19 Oct 2021 18:23:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8896E857
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 18:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSgSgrhyc5UAMhgQLSsFkj9t9nxWun0cxbALg9lXgKevWfRS1qjKBXmU12y7lydfjwZlmL4ZfOEPZAc1qeCf0QpAug7qzgIJ6RBNeDAsUuCFPNulffsyiTCwIe+BRKfjrlmrE5q3ykNumpDbwDe0KIdfnLbxPdtQQidJ0nLMILU9s10/7+tjJ1nl+hYmo5L1I7n0X5WYRkt4kNCGd9p7kNFoOUO/R/7hkqTjaH/X7kYwMVlYXv5ChKQrVhpVl1LJqWUTCH/YJLoDilasGcaqNYR1HBqoQmbhk/0rYPeMXmT+go6pqJ/1+2HYt0FiBlav9n7s911SPyDKUYZis8m6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w24OIcjBPanKp7PzKkz3IQgLtvQdNs5Gl1826XTycM=;
 b=KtvGK2J6p/CFAVrHVjM/HFrD19I+00CygOy8STOG6LIr9W4bWA5tIucI+Kdi7fFLE8raTCiiLWVuke5Xv49kaswrVpz5atzfklxXCLHJh21j03XV++wV/S44p9fQWm5WHs6XJHgloQkyD3CFSRBrpCEmj1UtgzxITx6DPW08R2f52sf/prs9epnySQ6LYLesGEVvMJRO74VKvzEZxlcDFjg6Km1ngHi7l0kvMRe1dBhoSCe0elvtFOdH3c4VfWz2w0bXR5jtohVSRGDwNEltrJP35ey5cN71f+LUsBSMsw4eixkHndky7+A+rrNM1Bm9Qyt0LuCDZTj2tNB/J4AAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w24OIcjBPanKp7PzKkz3IQgLtvQdNs5Gl1826XTycM=;
 b=nwLNwyTUwG6PMBsQtkWJ5lnMOd+q6XlVsh+CiBRlsFZmr44RdNV868O1hnxrAD2CpCheGD/8rgSwakL2UTAjtlcf7sKGF8/hGyXv6KBEgtkTOw1t41PVtAuX3ScuB3cX1JsLAygtX8gXIPptxwXIpb30h6IioQPnPwjfr4KtYS8=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM5PR1201MB0075.namprd12.prod.outlook.com (2603:10b6:4:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 18:23:19 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::545:e133:60d8:d646]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::545:e133:60d8:d646%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 18:23:18 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Add kernel parameter for ignoring bad
 page threshold
Thread-Topic: [PATCH 3/4] drm/amdgpu: Add kernel parameter for ignoring bad
 page threshold
Thread-Index: AQHXxRHm4aBUYTyVHUC/Fhwm8igFtavan8+AgAAClPA=
Date: Tue, 19 Oct 2021 18:23:18 +0000
Message-ID: <DM6PR12MB3324C25263BA4B5B2448F8D285BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
 <20211019175050.934527-3-kent.russell@amd.com>
 <12b72b9b-0b46-248d-fb85-82e442f59570@amd.com>
In-Reply-To: <12b72b9b-0b46-248d-fb85-82e442f59570@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-19T18:23:16Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=26a1c67c-21a8-4d82-9910-1d40cf6c6c76;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a24ba784-d67f-4531-0795-08d9932d868c
x-ms-traffictypediagnostic: DM5PR1201MB0075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0075CEE37DB44B90B33E50A485BD9@DM5PR1201MB0075.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwBv1UfgBssK3A3MBuCO6c1SGER8y0771ssx77JMnIBLK/fEwV23lq9GCzs6PzsseYhWN8woPYk/I42Qb6g7gTE/Dy0oNKUhbWeXJek3QWjKpgMc2Y4wozmoUi+qsbwgh+I/MPP26E2o9qeV49hOdjSlzXaJQkftF8Rrt1k3V7Tl1GCDjZH5l5v+/v0T9G7qwvVLO2/d0n29UkFGlbqq5XKCv2c8nh1UjEB05wzagZ9jV6XoJa6QxhOXg2JC4QfIfaRpk2cdaDRo0lVCuboqBWxAjFNYt61r1i4rACr2lvnBsfIZKT0mggcA2vJ+psJCstJqQ/FXz5JLwzeH+I++SoYvDeimfDZhHdvFQpHUg26duHJkqWFiBFXdJBIOhiehH3WyVH59uh75GdPKTandIAZ2k6Si+q3jP9eQXkTqcN62fJmu3FYqRDv/sKqMffb7j8CttMXsd8GeAmWEztSpdX3LGmEnDqvuFboaNmR854+xl7YGOGHVkywRXvEF/39aOYBQsSS3Es39m613LuNWy+XGqKukypDKFbTfdmWt3lI2CtoxBW0NBubd6h9ZIq1qthhXai+Y6xk+6LOIJDKZ5VZokWeRWbw+7a19Gx7lUti2vu140aidrtLtls8WVyRuK/iqB0smEUoJzpNxTP3NL8a9DUJO44ZhwAGN0RMlAJKb3AWRUbi+S3lBG2lDJ177Utb0eaPrurbxr514VIO1cw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(186003)(6506007)(66446008)(8936002)(38100700002)(122000001)(5660300002)(7696005)(55016002)(86362001)(54906003)(8676002)(66946007)(52536014)(26005)(2906002)(33656002)(76116006)(66556008)(53546011)(508600001)(4001150100001)(71200400001)(9686003)(316002)(110136005)(83380400001)(66476007)(64756008)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3JKa295Y0lzRmdCMHFYNzNtNFJTaUVnTDhxZlplMlpKVVVGYlhMYkhYTnRE?=
 =?utf-8?B?OExoMzJ4ZWtCZ2gvTCt6KzJaQ0tGOHdtZm03bUVlV2c3NUozV0dla214bDVh?=
 =?utf-8?B?Sldtc0dGUjFwWHUvQk1VazVoRG1JODgrQUZCRTNtT2szczNNdXFCTUVFb1BV?=
 =?utf-8?B?N1FFa0lEdTAyU1VmVzZSMnNkS01wV1M4dW1HUHdGTXpiY1dyRTJYRk0zL0Mv?=
 =?utf-8?B?MmNCd1JVUFMyK2VTeHRrWE5yMndGRkZBcUFKYXVQbTJISk5Ka3ptTXpxTllZ?=
 =?utf-8?B?TXRJOXpidzB6eG9JZzdaZnVSVk41NXVoNnVOUDRabThzdzAvWEdlS0ZLZXlo?=
 =?utf-8?B?MUxhS2pnbnRvdS9YSGR4T2NPZytHSHhTWXJlWENqVGc1SXp1MWdpNElCN1hI?=
 =?utf-8?B?bW1WRzdZeG5pSFRPUEZLOE1ZaEFxRlZWOFBFM2lFM0NhTXBDdW1KYm1ONFRB?=
 =?utf-8?B?d28wcW95VHNRVkVEZkdISFp4TGpKSWNOR09kbDlwcjNlWEhSaVJZSFFhKzRV?=
 =?utf-8?B?UDJ6OFJRYTQvOWJMR3p0bTF0THcvRU5KWHhvMVhqQUdCMlBkSW94NXVGMnRv?=
 =?utf-8?B?QkJ0R011R3ZhZ29jTkEvK1EvVkJmeGlUYmtFa1oyM3I2d3pNS28zdFppcG1s?=
 =?utf-8?B?MytScS9tYzYvRDZzTmdGRW9sL1FsR1pFNUcrUGZuUkg3RGI3WDhhRVBVTk5V?=
 =?utf-8?B?SDA1R2lodVVURDNQT0xDemZCVjVaYlpsVXloTXZLQmgxbWFORldOVXZMSm9y?=
 =?utf-8?B?VTd1R2JHZjdvYk1LMldpcnhGTFlVSUpkck51b1BpVjV6bnBzeXpIZ2dEa3g2?=
 =?utf-8?B?eWhFczk3VmdzWDhWMW12aTNqaitadzhiUStHZlRtS1ZDOVJUWlJRWnZOQVVF?=
 =?utf-8?B?a3IvWFJSZlV0ZnNqUm54UzZYajcxZkRFZjZjN003cVBYdjJpdEpEZ0V1UFpp?=
 =?utf-8?B?bVJPbE51MnJ2VkZPK1l6cXJ2eThtNkJ2aEs4TkZjME1WUFpnR2xBbmNPNDds?=
 =?utf-8?B?T3VScHArQk8wN1dMSjJXZzVuUVhtUWdpZzdYMVAyK3hNMTNadTdaOVVwSGIv?=
 =?utf-8?B?aE9iSnZDdFpkeWx5U0NYU3lFQW1IUTVVVnRjUlRvUnB5VHNQc0NGZW9QbnJw?=
 =?utf-8?B?WDRNOTU2Nm5wSVNxYTh5WVRXOENXMmVkYkd5ZlpnM3QxYmlMbXF6S0k5UnJz?=
 =?utf-8?B?UzhQRU91ZUVIdm5RZFRlVE8vcTkvRlB5UnVwSzdENGxGRzR3YXd5bmF2MEZI?=
 =?utf-8?B?aWNMT0tKMVFCbE1jQTlNMEJjU2NNNHQvdXNSVDc2eGNUMmluTVFsZTVHUzdl?=
 =?utf-8?B?S0doZDRMeEFoaUtySUtUWEN1TXM1SkxkaU1jb1RDK0UycGhTcHY1dHI4TTlL?=
 =?utf-8?B?QWd4ZEROSU9teG9BZldlZUtOUC9ka2kwYy9sZXYwMTRmbEpkd3g0MVRsSGcv?=
 =?utf-8?B?Rjg4S1Bsd3FTVk1JZVQreEVpekN1YmZNZzdVSGZSRkhtSlA0aXoyaklka0Yw?=
 =?utf-8?B?U0lEMlM2ektkNjkrZ2FnaUxsMXljang1eXR1QzhsOFhzR3FheStLSXZTZEpn?=
 =?utf-8?B?UnU2WnQ3QkwxTGU2VzBBZldDYkNsZGdna1RON2lUL3ZtdFhRa28rVkJSU1BM?=
 =?utf-8?B?TzRQRHB3MUs1SmNEUHpEK3hyVmdnZklSYmJ1dk12TUZSUjZMZS81T2RLcHFX?=
 =?utf-8?B?d0tFZ1lNaUh4WlQrcy9sMWZuWUdUQ0hXSitheldWT3lZUjNFWWpOcmRDNHBm?=
 =?utf-8?Q?ltf5riyOnjrK+cfJLa12lzWCS+36UGf55vx+KKO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24ba784-d67f-4531-0795-08d9932d868c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 18:23:18.8741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMEgMnSTikNu5Bbty3BaLGJ9PYYHk/dQ+2bJnPeMGOWrjdeo9G1oQWrqo1UfkoY/vTSrreQ7B183KdkkEsGP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0075
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBT
ZW50OiBUdWVzZGF5LCBPY3RvYmVyIDE5LCAyMDIxIDI6MTMgUE0NCj4gVG86IFJ1c3NlbGwsIEtl
bnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPjsgSm9zaGksIE11a3Vs
IDxNdWt1bC5Kb3NoaUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHJtL2Ft
ZGdwdTogQWRkIGtlcm5lbCBwYXJhbWV0ZXIgZm9yIGlnbm9yaW5nIGJhZCBwYWdlDQo+IHRocmVz
aG9sZA0KPiANCj4gDQo+IEFtIDIwMjEtMTAtMTkgdW0gMTo1MCBwLm0uIHNjaHJpZWIgS2VudCBS
dXNzZWxsOg0KPiA+IFdoZW4gYSBHUFUgaGl0cyB0aGUgYmFkX3BhZ2VfdGhyZXNob2xkLCBpdCB3
aWxsIG5vdCBiZSBpbml0aWFsaXplZCBieQ0KPiA+IHRoZSBhbWRncHUgZHJpdmVyLiBUaGlzIG1l
YW5zIHRoYXQgdGhlIHRhYmxlIGNhbm5vdCBiZSBjbGVhcmVkLCBub3IgY2FuDQo+ID4gaW5mb3Jt
YXRpb24gZ2F0aGVyaW5nIGJlIHBlcmZvcm1lZCAoZ2V0dGluZyBzZXJpYWwgbnVtYmVyLCBCREYs
IGV0YykuDQo+ID4gQWRkIGFuIG92ZXJyaWRlIGNhbGxlZCBpZ25vcmVfYmFkX3BhZ2VfdGhyZXNo
b2xkIHRoYXQgY2FuIGJlIHNldCB0byB0cnVlDQo+ID4gdG8gc3RpbGwgaW5pdGlhbGl6ZSB0aGUg
R1BVLCBldmVuIHdoZW4gdGhlIGJhZCBwYWdlIHRocmVzaG9sZCBoYXMgYmVlbg0KPiA+IHJlYWNo
ZWQuDQo+IERvIHlvdSByZWFsbHkgbmVlZCBhIG5ldyBwYXJhbWV0ZXIgZm9yIHRoaXM/IFdvdWxk
bid0IGl0IGJlIGVub3VnaCB0bw0KPiBzZXQgYmFkX3BhZ2VfdGhyZXNob2xkIHRvIHRoZSBWUkFN
IHNpemU/IFlvdSBjb3VsZCB1c2UgYSBuZXcgc3BlY2lhbA0KPiB2YWx1ZSAoZS5nLiBiYWRfcGFn
ZV90aHJlc2hvbGQ9LTIpIGZvciB0aGF0Lg0KDQpBaCBpbnRlcmVzdGluZy4gVGhhdCBjb3VsZCBk
ZWZpbml0ZWx5IHdvcmsgaGVyZS4gSSBoYWRuJ3QgdGhvdWdodCBhYm91dCBjby1vcHRpbmcgYW5v
dGhlciB2YXJpYWJsZS4gV2UgYWxyZWFkeSBjaGVjayAtMSwgc28gd2h5IG5vdCAtMj8gR3JlYXQg
aW5zaWdodC4gVGhhbmtzIQ0KDQogS2VudA0KDQo+IA0KPiBSZWdhcmRzLA0KPiDCoCBGZWxpeA0K
PiANCj4gDQo+ID4NCj4gPiBDYzogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4N
Cj4gPiBDYzogTXVrdWwgSm9zaGkgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgIHwgIDEgKw0KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAxMyArKysrKysrKysrKysrDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiBpbmRleCBkNThlMzdmZDAxZjQuLmI4NWI2N2E4
OGEzZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUu
aA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4gQEAg
LTIwNSw2ICsyMDUsNyBAQCBleHRlcm4gc3RydWN0IGFtZGdwdV9tZ3B1X2luZm8gbWdwdV9pbmZv
Ow0KPiA+ICBleHRlcm4gaW50IGFtZGdwdV9yYXNfZW5hYmxlOw0KPiA+ICBleHRlcm4gdWludCBh
bWRncHVfcmFzX21hc2s7DQo+ID4gIGV4dGVybiBpbnQgYW1kZ3B1X2JhZF9wYWdlX3RocmVzaG9s
ZDsNCj4gPiArZXh0ZXJuIGJvb2wgYW1kZ3B1X2lnbm9yZV9iYWRfcGFnZV90aHJlc2hvbGQ7DQo+
ID4gIGV4dGVybiBzdHJ1Y3QgYW1kZ3B1X3dhdGNoZG9nX3RpbWVyIGFtZGdwdV93YXRjaGRvZ190
aW1lcjsNCj4gPiAgZXh0ZXJuIGludCBhbWRncHVfYXN5bmNfZ2Z4X3Jpbmc7DQo+ID4gIGV4dGVy
biBpbnQgYW1kZ3B1X21jYnA7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYw0KPiA+IGluZGV4IDk2YmQ2M2FlZWRkZC4uM2U5YTdiMDcyODg4IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+IEBAIC0xODksNiAr
MTg5LDcgQEAgc3RydWN0IGFtZGdwdV9tZ3B1X2luZm8gbWdwdV9pbmZvID0gew0KPiA+ICBpbnQg
YW1kZ3B1X3Jhc19lbmFibGUgPSAtMTsNCj4gPiAgdWludCBhbWRncHVfcmFzX21hc2sgPSAweGZm
ZmZmZmZmOw0KPiA+ICBpbnQgYW1kZ3B1X2JhZF9wYWdlX3RocmVzaG9sZCA9IC0xOw0KPiA+ICti
b29sIGFtZGdwdV9pZ25vcmVfYmFkX3BhZ2VfdGhyZXNob2xkOw0KPiA+ICBzdHJ1Y3QgYW1kZ3B1
X3dhdGNoZG9nX3RpbWVyIGFtZGdwdV93YXRjaGRvZ190aW1lciA9IHsNCj4gPiAgCS50aW1lb3V0
X2ZhdGFsX2Rpc2FibGUgPSBmYWxzZSwNCj4gPiAgCS5wZXJpb2QgPSAweDAsIC8qIGRlZmF1bHQg
dG8gMHgwICh0aW1lb3V0IGRpc2FibGUpICovDQo+ID4gQEAgLTg4MCw2ICs4ODEsMTggQEAgbW9k
dWxlX3BhcmFtX25hbWVkKHJlc2V0X21ldGhvZCwgYW1kZ3B1X3Jlc2V0X21ldGhvZCwNCj4gaW50
LCAwNDQ0KTsNCj4gPiAgTU9EVUxFX1BBUk1fREVTQyhiYWRfcGFnZV90aHJlc2hvbGQsICJCYWQg
cGFnZSB0aHJlc2hvbGQoLTEgPSBhdXRvKGRlZmF1bHQNCj4gdmFsdWUpLCAwID0gZGlzYWJsZSBi
YWQgcGFnZSByZXRpcmVtZW50KSIpOw0KPiA+ICBtb2R1bGVfcGFyYW1fbmFtZWQoYmFkX3BhZ2Vf
dGhyZXNob2xkLCBhbWRncHVfYmFkX3BhZ2VfdGhyZXNob2xkLCBpbnQsIDA0NDQpOw0KPiA+DQo+
ID4gKy8qKg0KPiA+ICsgKiBET0M6IGlnbm9yZV9iYWRfcGFnZV90aHJlc2hvbGQgKGJvb2wpIEJh
ZCBwYWdlIHRocmVzaG9sZCBzcGVjaWZpZXMNCj4gPiArICogdGhlIHRocmVzaG9sZCB2YWx1ZSBv
ZiBmYXVsdHkgcGFnZXMgZGV0ZWN0ZWQgYnkgUkFTIEVDQy4gT25jZSB0aGUNCj4gPiArICogdGhy
ZXNob2xkIGlzIGhpdCwgdGhlIEdQVSB3aWxsIG5vdCBiZSBpbml0aWFsaXplZC4gVXNlIHRoaXMg
cGFyYW1ldGVyDQo+ID4gKyAqIHRvIGlnbm9yZSB0aGUgYmFkIHBhZ2UgdGhyZXNob2xkIHNvIHRo
YXQgaW5mb3JtYXRpb24gZ2F0aGVyaW5nIGNhbg0KPiA+ICsgKiBzdGlsbCBiZSBwZXJmb3JtZWQu
IFRoaXMgYWxzbyBhbGxvd3MgZm9yIGJvb3RpbmcgdGhlIEdQVSB0byBjbGVhcg0KPiA+ICsgKiB0
aGUgUkFTIEVFUFJPTSB0YWJsZS4NCj4gPiArICovDQo+ID4gKw0KPiA+ICtNT0RVTEVfUEFSTV9E
RVNDKGlnbm9yZV9iYWRfcGFnZV90aHJlc2hvbGQsICJJZ25vcmUgYmFkIHBhZ2UgdGhyZXNob2xk
IChmYWxzZSA9DQo+IHJlc3BlY3QgYmFkIHBhZ2UgdGhyZXNob2xkIChkZWZhdWx0IHZhbHVlKSIp
Ow0KPiA+ICttb2R1bGVfcGFyYW1fbmFtZWQoaWdub3JlX2JhZF9wYWdlX3RocmVzaG9sZCwNCj4g
YW1kZ3B1X2lnbm9yZV9iYWRfcGFnZV90aHJlc2hvbGQsIGJvb2wsIDA2NDQpOw0KPiA+ICsNCj4g
PiAgTU9EVUxFX1BBUk1fREVTQyhudW1fa2NxLCAibnVtYmVyIG9mIGtlcm5lbCBjb21wdXRlIHF1
ZXVlIHVzZXIgd2FudCB0byBzZXR1cA0KPiAoOCBpZiBzZXQgdG8gZ3JlYXRlciB0aGFuIDggb3Ig
bGVzcyB0aGFuIDAsIG9ubHkgYWZmZWN0IGdmeCA4KykiKTsNCj4gPiAgbW9kdWxlX3BhcmFtX25h
bWVkKG51bV9rY3EsIGFtZGdwdV9udW1fa2NxLCBpbnQsIDA0NDQpOw0KPiA+DQo=
