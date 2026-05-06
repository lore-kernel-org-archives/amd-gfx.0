Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52EACD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 06:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4955810E161;
	Wed,  6 May 2026 06:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uasswE3z";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8FC10E161
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 06:08:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls0rbt/RWs2pgtaM8E0K1UbG2AVWeRDzQlmSOgdaVXursznFSJsk9arco8zZZvwfim4Rf0xGrJ/XFR7HOmnhSsFI5pzIIt7oyAfFCBHyidw0hgZfqQmUr36JnQjnK0ODoDmA6c2HSH+shMYIqFw47kxqatmVXlr5waEcIxtHJNK2C/0iGhsC/9MCu9Fda0rIgyTxT8HnpXvZtOkTQpR7I0UxPmTWx7XsybQghlr4A06RbyyTNW/QBnfcUQ/jICP98I2XkxPFthAD0YY+TFtqmB2hPHv3s0snF7rMXaKg6E+jrYvEyocrLm47gYlhUMyKTrH27pylLY/keurt53yAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eMXqyEbHiD/xAchhxrOFO+9qvlmoyoj8fe8TONjXG8=;
 b=i/awwhKIfSpGr+vf9U0wShDY7g/soD84lytF0clMVtTDNSauMS1wAfRWFY+8LQ9Q1BkscQGKeGjeoC29C0t9QFff2COFJs5jl1hTKSWbF0N4owZWNlE2Wpx/4doJfH/1RrTcztlfsS4Sq26xrxeIVsAx5LADQuxDSaMoeNZCgWK461O0AvIXAjRzaoc7p2I0N8Mmtz6yQb75Uv3H+tjT0BFokU1/HI6btA0HA5xKr750jU20KEzNlJQwKjFNaQZhPVmrRlLX9XMFMMRZLLWbpOId7Owm+q+s1MZwyjzXHqTpON7mOrDMmctEGsGGOd3A9xFH8xTH2T2b626weyCuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eMXqyEbHiD/xAchhxrOFO+9qvlmoyoj8fe8TONjXG8=;
 b=uasswE3zKztmedzGXfYXkpY4QoYw/kRETMuZXomNJT1g0rApT2zj61WCnGh54bj/W5aeEyPDYcmqYF6g38lZMWAXpPgU0RXXR1mGCqhvUHYDJaHgjQUBQEJFEs8weOw+iSd0L5aOXgwqj5dzb3gF94lUhzrzRsHbEBEICog/5wQ=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 06:08:52 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 06:08:52 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v4 10/10] drm/amdgpu/userq_fence: NOTIFY MES on SDMA UMQ
 submit
Thread-Topic: [PATCH v4 10/10] drm/amdgpu/userq_fence: NOTIFY MES on SDMA UMQ
 submit
Thread-Index: AQHc2LxE7EQwqVf3z0Cllad9Ud8XxrX5K/gAgARrsYCAAvFiUA==
Date: Wed, 6 May 2026 06:08:52 +0000
Message-ID: <DM4PR12MB5152E6B971F2830E7141089CE33F2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
 <20260430161146.2851078-10-Jesse.Zhang@amd.com>
 <CADnq5_N_PwKyX4-gmDc7xWWB3AL0CVYJXzomgOXER0c72-c_oA@mail.gmail.com>
 <dcd83794-5387-4892-991f-4933845048db@amd.com>
In-Reply-To: <dcd83794-5387-4892-991f-4933845048db@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-06T05:57:44.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA1PR12MB7638:EE_
x-ms-office365-filtering-correlation-id: 87c6422b-fceb-4522-6dc1-08deab35f2a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Kgff1SKxygLM6dPkIzanP+SaP3QhFEkGU2Ba6ie5H1vrKXiHohb3X+h7md4R4DH2gS7LnWEDkFLwtqShTLSJrb152Ah4VEizLoCq7IQeOjS6VfcQ89/SO8GX2MYtGbz942MP34pf5RxdB36x7XVGbm0MwRe60ONNFxeUf/KPu8M7p50V9EXVZxAMHPJeF/+GXInuMaLXXjDYddudVv2039rhedFRcFyYm/DOpZQwSzXefhasZXgg2pvVBnNu66cHX1uonusJuXwuPledtS1CBs3pn5YEG3YQ3Pyg1WjIsm9PDz1PB+/fFfjY3Ge9pJyovKQkgCLNUPFIzK7Zqiqr0/POd/bptxbNBEPbaRF7RnNDuAfxAyZbiR2++2MZYAUmDguS7FwSAG7IOpipSebm4OwAoaRuSN9UPB1kTtXcbluqRpPEyJWSSYLAEBQcFV7QJeTcH8oWuRDmYEwUJwiHyWQsWMoSoTZvrfKEJOMPXcA49Cs14u78IzIKDihKFhKgIwdqmrqrhBEbWkIzi2S8TjfdkqDVt96MG1TDpof72n09m17ngvJzRgbiVBBVN2jViSUmnJqdyXuI23V8wEc58c7FgiThdrJW8TPr6TlvTsSEq44Rfuz2BQ+jIvNgQCMpHIT5WeNjXmDbWm7CB7/NBGTmmG3lpflsN83OLLBWBQtkbe70J3DsvYo8ZF/dFXrO10kOAA4to7taCHzO4OWj4MRNmAgLHZtB8aEMn9EGtBkOpM8vtR/jaS0oycLkoHek
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUk0S3VSWVpRWFJQM1FaSW03bEhNSFBUbkJCbUt0K1dTOWtuU2IyUE10VmRi?=
 =?utf-8?B?Y0Y3NC9VQjJsdy9HeWx4ano5MDk4OUdjVElETVJMMWZ0SG1NRjAwYkU3WTNy?=
 =?utf-8?B?L0NqcUlyL1AweDl0aHpGS0IwcjRvOFhwOE85V21RekxhNXF4MEk0dmZNeFJ3?=
 =?utf-8?B?bmxmQ3VobldCNnBZNk5hNzdBU0pHdi9pdFhBdjRSaXRrc3pFWUVJNGNmdUFj?=
 =?utf-8?B?YkhBendwSHErNlNiemI1NXduaDBhYVREQndMZ04yNEIvRUNWVmtlV25aVHBK?=
 =?utf-8?B?cXFmZVFteVRPTjB0RHY4Y3lDNERaT1E1TjFhVVI0MDFHcUpoSHNYd1pEVElp?=
 =?utf-8?B?ME9jSDg1bGZ3OVMxdWZpZUpiSmJFUGxGWHpBUHpVdVQ5WUtocU42R0pOaHgw?=
 =?utf-8?B?b3U5RjhwYnBBcnpFcGJuWko5ZFZoTU5rV1BtMXdWOXBkNXlySXBNWUFyMVZD?=
 =?utf-8?B?RXRRRjN5cGx0Y0QycmFsNnh5WjRJOWRmeEk1RzJvU2EzUFlGVk1nSFRVYUZN?=
 =?utf-8?B?WTJXTmpVWWtOcGRUMGM3NExFVzNObVRJbDJvdnVpcVFsNlpiZ1NXTVVmazM1?=
 =?utf-8?B?dExEaFRvZytjaS9tSzRlbDVNVDdRK0RicGwzcHdKZmFCMG9EQUk5MEk5dTJt?=
 =?utf-8?B?THBUS1UyWHEwU0sySUVGd3RJMGYzcGZ2Z25ldXZscGtScXcrZml1b1Q0ZjFv?=
 =?utf-8?B?cTBXSk5aanYwc3FNeFo4cFpQakNvWTZjNUFQWVgvMmhrcWVYL2wyQXNaQmtk?=
 =?utf-8?B?bDYvWkdJL255OFh0bjV4ajJGdEtLaGo5SlpKNXZ4MURoYU9TaEd2cVFNa3Rp?=
 =?utf-8?B?SzkwWmRlaUFVTC91djI1YmM4Tm52Nm9Qb1V3U1NyaHdrWkYrYjE3c3AyaElC?=
 =?utf-8?B?OHFHZ1RTMXlLbTN4SWtHYlpHcUg1WGMzUnBCZU5PbDNMZzJuNnZRWXpyVmg2?=
 =?utf-8?B?MmdwNkhvUlRtdTB3ZlV6Ukt1K3pwVjhVa0ovQ09acUtlNVpQTzNILzlpTHRG?=
 =?utf-8?B?RjRxMHZLTmNQVWU0ZDFKaTcwUnJpZ3Faa0U1Tk1rcGlrTEorQ2NHQlVLSmN1?=
 =?utf-8?B?YlU3cENmeTRRQitoRHZ6Rm5RaUhRb2o1NVd5WlVmR3dzbnc1NFM2ZWRRMGN2?=
 =?utf-8?B?MFpiRXA4MTg5bGZEQ252ZWFGcWxKSE1sN3loRmlwU2lHZTRIOXNDZ3Z4Rk1j?=
 =?utf-8?B?REoyMEN5Z0ZwRzRxd3RkTWFjMGN3VEV6bnhPY0tmSVRWVXdyS05NR3pQZzRa?=
 =?utf-8?B?NGpEbXd1WFdMRUdyLzMrU3pGM1VYeUZrYlVUMkx1clNvU1pmNEVhRGVIbFZT?=
 =?utf-8?B?aHQ0bEhXdVp3OFNmVjExZUtZQU11ZmdGUkQ0MjlqNm1ETWNSVzJGa2dxYUQz?=
 =?utf-8?B?RXJGdEpwM3o1YWhuTFBjYndNSWM5UjVNd2RnV1BML2hUS0g3ZE5JRnA2bHRX?=
 =?utf-8?B?a0Ircy9KK21qMmpmTFVnS1lVSkc3VkpEcXppcVBjV0FWRFAybFVCZWtDU21l?=
 =?utf-8?B?UjdNd0lyeGJJbVNtTFJLNFV1YkJnYUtZRk0zZGVNTWZuUStIQVFscVVLSTg3?=
 =?utf-8?B?b3cxZnRXbnhFVGUxM0pJNitCRWRyUUVYSGljckoxdlNhS1draTlTdElhWnBu?=
 =?utf-8?B?OWNNOU5zZ0dKVngwR1hDQjRwMnpIbm81ZU95bHBoMHFIZmt0RGRLMHZwZXJC?=
 =?utf-8?B?dXh4YzlydEFWaElyS1JZa1QxZHJHQUxXYkErcWNjOVFQWlIvVzEwcXN0SWhs?=
 =?utf-8?B?d2FpQzM4VWplYUkyeGZZREwva0dlTDY2NEg2MWdRSzhBVTZ1T0VhZGlRVC9j?=
 =?utf-8?B?aEF2M052b3BwUkdxenZ1S3dtSEVpaFU4MFprN3A3ZDJIVzM3Q1NZMHAwOWhi?=
 =?utf-8?B?aWprdGpXcVZ4cC9HYXNMOWR0VmNYRDdadllsdkpVZGF4WFllZnh4VnpGL3Z2?=
 =?utf-8?B?ZkFiamZVUXdqN2lqaGY0bmZrMGhxWW1OUmlVL3hjOXU4UExmRFFCbHhOaUJ5?=
 =?utf-8?B?UTZLUXJ6WmNMZGFNNmhiN0tuR3lmak1JUEhjT0lvTUhhRmVqaVMyTHZ2OUo1?=
 =?utf-8?B?QzFOMFIvUzUwWklsakZsNHZrcVhDWlZmYjNuTURwcllpOHQ0aGVGb3Q5Q0lh?=
 =?utf-8?B?bGpIa25oNnZFdFFNT1JwK2toOW1KNmRGa1RxZkZScmtTQ3d2SzIxcmhzaHlN?=
 =?utf-8?B?UmxiL0gzQUVXNkhJWndCc2tMRjYzSzZaT0tGR0tGRk1HMUZmRUZCaTc5UllF?=
 =?utf-8?B?ZitxVzlQM0JqQWpHQkppSHZqd2hSK0FXbUw0Q0pIdCsrWlgyMEpHWjh1czE2?=
 =?utf-8?Q?Q4kj+Ep8smRyed4rYA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c6422b-fceb-4522-6dc1-08deab35f2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 06:08:52.5426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGZ60rty1eqlCGZbAc2aElBbbwJZqncmhXxdv59M0bmtBatArb43ncqGv7kOYmq/J9fLAxIb+XKKmIrc7EJYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXks
IE1heSA0LCAyMDI2IDU6MDEgUE0NCj4gVG86IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPjsgWmhhbmcsIEplc3NlKEppZSkNCj4gPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+IENj
OiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEwLzEw
XSBkcm0vYW1kZ3B1L3VzZXJxX2ZlbmNlOiBOT1RJRlkgTUVTIG9uIFNETUENCj4gVU1RIHN1Ym1p
dA0KPg0KPiBPbiA1LzEvMjYgMTU6MzAsIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gPiBPbiBUaHUs
IEFwciAzMCwgMjAyNiBhdCAxMjoyOeKAr1BNIEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQu
Y29tPg0KPiB3cm90ZToNCj4gPj4NCj4gPj4gRnJvbTogIkplc3NlLnpoYW5nIiA8SmVzc2Uuemhh
bmdAYW1kLmNvbT4NCj4gPj4NCj4gPj4gUGFpciB0aGUgdXNlcnNwYWNlIGFnZ3JlZ2F0ZWQtZG9v
cmJlbGwgcmluZyAoYWRkZWQgYnkgdGhlDQo+ID4+IEFNREdQVV9JTkZPX0RPT1JCRUxMIC8NCj4g
QU1ER1BVX0dFTV9HTE9CQUxfQUdHUkVHQVRFRF9ET09SQkVMTCBBQkkgaW4NCj4gPj4gdGhlIHBy
ZXZpb3VzIHBhdGNoZXMpIHdpdGggYSBrZXJuZWwtc2lkZQ0KPiA+PiBNRVNfTUlTQ19PUF9OT1RJ
RllfV09SS19PTl9VTk1BUFBFRF9RVUVVRSBpbg0KPiA+PiBhbWRncHVfdXNlcnFfc2lnbmFsX2lv
Y3RsIGZvciBTRE1BIFVNUXMuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5n
IDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiA+DQo+ID4gSG93IHdpbGwgdGhpcyB3b3JrIGlmIHRo
ZSB1c2VyIGRvZXNuJ3QgdXNlIHRoaXMgSU9DVEw/ICBwcm90ZWN0ZWQNCj4gPiBmZW5jZXMgYXJl
IG9wdGlvbmFsLiAgQW4gYXBwbGljYXRpb24gY2FuIGNyZWF0ZSBhIHVzZXIgcXVldWUgYW5kIG5l
dmVyDQo+ID4gdXNlIGEgcHJvdGVjdGVkIGZlbmNlLiAgV2h5IGRvbid0IEtGRCBTRE1BIHF1ZXVl
cyBuZWVkIHRoaXMgc3BlY2lhbA0KPiA+IHRyZWF0bWVudD8NCj4NCj4gWWVhaCBhZ3JlZSB0aGF0
IHdob2xlIGFwcHJvYWNoIGRvZXNuJ3Qgd29yay4NCj4NCj4gV2hhdCB3ZSBjb3VsZCBkbyBpcyBz
aW1pbGFyIHRvIHRoZSBNTSBxdWV1ZXMgdGhhdCB1c2Vyc3BhY2UgbmVlZCB0byBzaWduYWwgYm90
aCBhDQo+IHBlciBxdWV1ZSBkb29yYmVsbCBhbmQgYW4gYWdncmVnYXRlZCBvbmUgZm9yIHRoZSBx
dWV1ZSB0eXBlLg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQpIaSBDaHJpc3RpYW4sIEFs
ZXgsDQoNCkFncmVlZCwgYW5kIHdpbGwgZHJvcCB0aGlzICBwYXRjaC4NCg0KVGhlIE1NLXN0eWxl
IHVzZXJzcGFjZSBBQkkgaXMgYWxyZWFkeSBpbiBwbGFjZTogRGF2aWQncyBhZ2RiX2JvDQooQU1E
R1BVX0dFTV9HTE9CQUxfQUdHUkVHQVRFRF9ET09SQkVMTCArIEdFTV9PUF9PUEVOX0dMT0JBTCkg
cGx1cyBwYXRjaCA5DQooQU1ER1BVX0lORk9fRE9PUkJFTEwgcmVwb3J0cyB0aGUgU0RNQSBhZ2Ri
IHNsb3QpLiAgSUdUIHJpbmdzIHBlci1xdWV1ZSArDQphZ2dyZWdhdGVkIG9uIGV2ZXJ5IHN1Ym1p
dC4NCg0KVGhlIHJlbWFpbmluZyBnYXA6IG9uIE1FUzEyICwgYSBiYXJlIGFnZ19kYiByaW5nIGRv
ZXMgTk9UIHdha2UgYW4NCnVubWFwcGVkIFNETUEgVU1RIOKAlCBNRVMgbmVlZHMgaGFzUmVhZHlR
dWV1ZXMgc2V0LCB3aGljaCB0b2RheSBvbmx5DQpOT1RJRllfV09SS19PTl9VTk1BUFBFRF9RVUVV
RSBmbGlwcy4gIFRoaXMgaXMgYnkgZGVzaWduLCBub3QgTGludXgtb25seS4NClRoZSBXaW5kb3dz
IFVNUSBwYXRoICBhbHNvIHVzZXMgdGhlIHNhbWUNCmNvbnRyYWN0IOKAlCBNRVMgd3JpdGVzIDEg
dG8gKnVubWFwX2ZsYWdfYWRkciBvbiBwcmVlbXB0OyBVTUQgY2hlY2tzIHRoZQ0KZmxhZyBhbmQg
Y2FsbHMgTk9USUZZIGJlZm9yZSByaW5naW5nIGRvb3JiZWxscyBvbiB0aGUgbmV4dCBzdWJtaXQu
DQoNCk5leHQgdmVyc2lvbiB2NSAobWF0Y2hlcyBXaW5kb3dzKToNCg0KICAtIERyb3AgcGF0Y2gg
MTAuDQogIC0gS2VlcCBEYXZpZCdzIEFCSSArIElORk9fRE9PUkJFTEwuDQogIC0gQWRkIGEgc21h
bGwgc3RhbmRhbG9uZSBOT1RJRlkgaW9jdGwgKGUuZy4gQU1ER1BVX1VTRVJRX09QX05PVElGWV9X
T1JLKQ0KICAgIHNvIFVNUSBhcHBzIGNhbGwgaXQgb24gZGVtYW5kLg0KDQogIElzIGl0ICB0aGUg
cmlnaHQgZGlyZWN0aW9uPw0KDQpBdHRhY2hlZCB0ZXN0IHJlc3VsdHMgKGN1cnJlbnQgdjQsIHdp
dGggdGhlIHRvLWJlLWRyb3BwZWQgc2lnbmFsX2lvY3RsIE5PVElGWSk6DQoNCiAgSFcgLyBmdyA6
IGdmeDEyDQogIFRlc3QgICAgOiBJR1QgYW1kX3VzZXJxX3NkbWEgc3RyZXNzLCAxMDAgaXRlcnMN
CiAgUmVzdWx0ICA6IDEwMC8xMDAgUEFTUw0KDQpTbyB0aGUgYWdnX2RiICsgTk9USUZZIG1lY2hh
bmlzbSB3b3JrcyBvbiBoYXJkd2FyZS4NCg0KVGhhbmtzLA0KSmVzc2UNCj4NCj4gPg0KPiA+IEFs
ZXgNCj4gPg0KPiA+PiAtLS0NCj4gPj4gIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vz
ZXJxX2ZlbmNlLmMgICB8IDI5DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPj4gIDEgZmlsZSBj
aGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4+IGluZGV4IGE1ODM0
MmMyYWM0NC4uNTBlMjc1YjUxYzllIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+PiBAQCAtNTk4LDYgKzU5OCwz
NSBAQCBpbnQgYW1kZ3B1X3VzZXJxX3NpZ25hbF9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZQ0KPiAq
ZGV2LCB2b2lkICpkYXRhLA0KPiA+PiAgICAgICAgIC8qIGRyb3AgdGhlIHJlZmVyZW5jZSBhY3F1
aXJlZCBpbiBmZW5jZSBjcmVhdGlvbiBmdW5jdGlvbiAqLw0KPiA+PiAgICAgICAgIGRtYV9mZW5j
ZV9wdXQoZmVuY2UpOw0KPiA+Pg0KPiA+PiArICAgICAgIC8qDQo+ID4+ICsgICAgICAgICogU0RN
QSBVTVEgd2FrZTogU0RNQSBoYXMgbm8gQ1BfVU5NQVBQRURfRE9PUkJFTEwgSFcNCj4gaW50ZXJj
ZXB0LCBzbw0KPiA+PiArICAgICAgICAqIG9uY2UgTUVTIGdhbmdzIHRoZSBxdWV1ZSBvdXQgKGFm
dGVyIHRoZSBmaXJzdCBJQidzDQo+IFBST1RFQ1RFRF9GRU5DRQ0KPiA+PiArICAgICAgICAqIGlk
bGVzIHRoZSBxdWV1ZSksIHBlci1xdWV1ZSBkb29yYmVsbCByaW5ncyBoaXQgYSBtYXBwZWQtb3V0
IEhXDQo+ID4+ICsgICAgICAgICogc2xvdCBhbmQgYXJlIHNpbGVudGx5IGRyb3BwZWQg4oCUIEZF
TkNFIElSUSBuZXZlciBmaXJlcy4NCj4gPj4gKyAgICAgICAgKg0KPiA+PiArICAgICAgICAqIFVz
ZXJzcGFjZSByaW5ncyB0aGUgcHJpb3JpdHkncyBNRVMgYWdncmVnYXRlZCBkb29yYmVsbCBkaXJl
Y3RseQ0KPiA+PiArICAgICAgICAqIHZpYSB0aGUgYWdkYl9ibyBtbWFwIChzZWUgQU1ER1BVX0lO
Rk9fRE9PUkJFTEwgKw0KPiA+PiArICAgICAgICAqIEFNREdQVV9HRU1fR0xPQkFMX0FHR1JFR0FU
RURfRE9PUkJFTEwpLiAgVGhhdCBhbG9uZSwNCj4gaG93ZXZlciwgaXMNCj4gPj4gKyAgICAgICAg
KiBub3QgZW5vdWdoIG9uIGN1cnJlbnQgTUVTMTIgZmlybXdhcmUg4oCUIE1FUyB3aWxsIG5vdCBz
Y2FuIHRoZQ0KPiA+PiArICAgICAgICAqIHByaW9yaXR5J3MgcXVldWUgbGlzdCB1bmxlc3MgaXRz
IGhhc1JlYWR5UXVldWVzIGZsYWcgaXMgc2V0Lg0KPiA+PiArICAgICAgICAqIE5PVElGWV9XT1JL
X09OX1VOTUFQUEVEX1FVRVVFIGZsaXBzIHRoYXQgZmxhZywgc28gTUVTDQo+IHRoZW4NCj4gPj4g
KyAgICAgICAgKiBwcm9jZXNzZXMgdGhlIGRvb3JiZWxsIHJpbmcgYW5kIHJlLU1BUF9RVUVVRXMg
dGhlIFNETUEgVU1RLg0KPiA+PiArICAgICAgICAqDQo+ID4+ICsgICAgICAgICogVGhpcyBpcyBh
IGtlcm5lbC1zaWRlIGNvbXBhbmlvbiB0byB0aGUgdXNlcnNwYWNlIGFnZyBkb29yYmVsbA0KPiA+
PiArICAgICAgICAqIHJpbmc7IHJlbW92ZSBvbmNlIGZpcm13YXJlIGxlYXJucyB0byB3YWtlIG9u
IGJhcmUgYWdncmVnYXRlZA0KPiA+PiArICAgICAgICAqIGRvb3JiZWxsLg0KPiA+PiArICAgICAg
ICAqLw0KPiA+PiArICAgICAgIGlmIChxdWV1ZSAmJiBxdWV1ZS0+cXVldWVfdHlwZSA9PSBBTURH
UFVfSFdfSVBfRE1BICYmDQo+ID4+ICsgICAgICAgICAgIGFkZXYtPmVuYWJsZV9tZXMgJiYgYWRl
di0+bWVzLmZ1bmNzLT5taXNjX29wKSB7DQo+ID4+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgbWVz
X21pc2Nfb3BfaW5wdXQgb3AgPSB7IDAgfTsNCj4gPj4gKw0KPiA+PiArICAgICAgICAgICAgICAg
b3Aub3AgPQ0KPiBNRVNfTUlTQ19PUF9OT1RJRllfV09SS19PTl9VTk1BUFBFRF9RVUVVRTsNCj4g
Pj4gKyAgICAgICAgICAgICAgIG9wLm5vdGlmeV93b3JrLnByaW9yaXR5X2xldmVsID0NCj4gQU1E
R1BVX01FU19QUklPUklUWV9MRVZFTF9OT1JNQUw7DQo+ID4+ICsgICAgICAgICAgICAgICBhbWRn
cHVfbWVzX2xvY2soJmFkZXYtPm1lcyk7DQo+ID4+ICsgICAgICAgICAgICAgICAodm9pZClhZGV2
LT5tZXMuZnVuY3MtPm1pc2Nfb3AoJmFkZXYtPm1lcywgJm9wKTsNCj4gPj4gKyAgICAgICAgICAg
ICAgIGFtZGdwdV9tZXNfdW5sb2NrKCZhZGV2LT5tZXMpOw0KPiA+PiArICAgICAgIH0NCj4gPj4g
Kw0KPiA+PiAgZXhlY19maW5pOg0KPiA+PiAgICAgICAgIGRybV9leGVjX2ZpbmkoJmV4ZWMpOw0K
PiA+PiAgcHV0X2dvYmpfd3JpdGU6DQo+ID4+IC0tDQo+ID4+IDIuNDkuMA0KPiA+Pg0KDQo=
