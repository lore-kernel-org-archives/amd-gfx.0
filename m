Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4446C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 03:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B3C10F7E9;
	Tue, 12 Jul 2022 03:44:35 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20EBF10F7E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 03:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4eO9ZE71HbMg0lRA1cdK15HsitDzQnWLHXBUltmTvb6bXkCVE0sBMd9Ktj+e3zeakVUkGf+sf5lvetFMK2PgTiphVaruXxcMgsKQHOsTFAwGzq3dBKFPbjBlS9stZeSiDWPrxqbcjL6npyg0KY0RYZuj2xLN9FqZtHWY84IqzEuGxGPbFpcu3mfO31o/iOs/hdcFvoo6esgMvJ7uia+dxmnMDRh5tfM/vMIzAUCq4osiGJFlv+h9ZvBr1TG6cUVRRbA4a/OD3xXpD2tjPX2ZX1l3MJQZBs9rgjEeIYLJPE+CioapO4Z4qYyJV6uMvhP+pDmOEQKVVaoroPhFPy3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG8uzi2NHQWdzVha5eBqwWh0U8AhwKdfl6LqjkVl3uY=;
 b=hZhtoOYScvUUUY8mvJ2JsZvI26gIq06p3bwT3+5iGBNfMuNvnci+N7dTxPaWm6W1jGnrFLIgpvFj+3U1TTg2H+aUROr564Ws8kg+z4Fdmm8rwR2wBAwRkh1HcFUSEvebYKR20oBr0LMOzxxe/nOloCzfY2LyQLLJx3PObhEIdPF+AheVA9ukkscv4vtl63Zm1Lqxfcsa6yfGD4qMFQVygl5G+Au1Bn8KyQqJhkUPEEyR7jFWKEn6Rz9VRDGJLyKhEcO+d9leLLtRTFObSqJBQ59bYReQXzqdzLmwKjEKazIp7qLjPbzQcopqzixh/iXu7d8XpetbOI8Y8pQNtSwHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG8uzi2NHQWdzVha5eBqwWh0U8AhwKdfl6LqjkVl3uY=;
 b=IFnKZtt069CHK+qVUTFjau8O3pEm5xLL/zv4Igf8/lKTS7tCE6yzHEZEVvOiqCPZkUq8uhpNr9MpJt595vdNm39VTxivVKYXCLCkMODLOfQw0DCXTvvZm9Z1Nj153fIN7KQBsyCZXkkZiMv364iBSO88pWuAnHVmLedzrnSSjAE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 03:44:32 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 03:44:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
Thread-Topic: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
Thread-Index: AQHYlS4+qhMJhXm4xUe/xTP1MWYtaq15S40AgADNMPA=
Date: Tue, 12 Jul 2022 03:44:31 +0000
Message-ID: <DM5PR12MB2469287939E24C24CC1EF0F2F1869@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220711135742.11739-1-guchun.chen@amd.com>
 <CADnq5_MvQUbixcowtu2KaD+giO4tFue48vCx=37SG4Q27XsOqg@mail.gmail.com>
In-Reply-To: <CADnq5_MvQUbixcowtu2KaD+giO4tFue48vCx=37SG4Q27XsOqg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20367c2b-35e2-49d7-f631-08da63b8d49b
x-ms-traffictypediagnostic: DM8PR12MB5495:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvyJ4Xnd1WH+piudB5XTnvB96VCV7u9M2zheIdXvKYj7CDcZwqNwaxzTj9rmaP75QPLQN5KzhWzZWZBd3nSk56a6FZIe63iaaZuS22/ywj+5VY99Trd5UBh8GL5iqjhMFf3frhC7IwVBNmxbHl9ZvPFuCVVLj0+JLY42CvYdr6XsrEhIVp4OKu5m0JDttbPVkrkX87r6a8eJcy0rP3q/vDqGQ4GvJn0RuQ7Q//7N7As64I6h60T7n9/ix4KTrD/NVlOUr0lmTMUNtPKC/6AvhIZGaujJX3RmDPZ2VsaWSjxVlCniFXeX+QkyfdDe4uiBQ1dcGhjleXhzEqiVOfCifrhjsQMWE6tlcFZZPt0D8mF8D7xtuluO5xA7G5cjGeoSKVifTf59YFINCaZbIYqPN6bNSuGyojFuYDWoyApLju5W7m1Jd8a/6oCZnuizJEEYvWbnN0QCDweoHIeo4uI/KMWcGj/d7jO9A0paJ+D3n6085g9yKU3P4GBtIBtjwp5EfW6/L2cxgT7DCIC7TOBuXeNDHP1veN8oL+V52IVJZRO8f310Io8uXvy/KpEDgHYcJvE/7LzyQ3XkuhiRAjkyOaQyTuThins5Pq7i/Ce7PDnlVM1aWmX7jl3/eDIB9Iqw30k390xWeZpjxeKtGEmDrVP1K7ijXC0qQLN8InGmZZkSsmsS+q3zN4Q0RXy7DuG+r5fzpEftvWxZA6qufWyiGaQEZSwjdj39Qo6GYzBtGdnzwEoE2PquD4GwvnYKfGr3TsRD63NqTLNgQWs8o3q+GyXJSZ4Z8SLbHRQG++UmR56+QXRaY/iqViy41nvmI20N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(33656002)(186003)(53546011)(66556008)(26005)(9686003)(7696005)(86362001)(55016003)(38070700005)(6506007)(122000001)(38100700002)(66476007)(83380400001)(52536014)(66946007)(478600001)(8936002)(2906002)(5660300002)(316002)(64756008)(6916009)(4326008)(41300700001)(54906003)(8676002)(66446008)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVl2YUxha0dLYi9MWDFZVGNrazFaeDV0MG9ncXd0bExkakN3WjA0aWhaeG5u?=
 =?utf-8?B?bVFsMGpXYVRRWmZ4R1lXMHZjZWhUV2dzc0xNSHFaUGM0THcyTG8xYXZXZGQz?=
 =?utf-8?B?ZmpWS3VteFRyZ2hyckpQTGZaU29mREdTQXFOUVpvdnJrdFpSdzVUdFhuTXc4?=
 =?utf-8?B?MWFONUF0L3ZCdFlYZ3R6WWk2U1ovZFUreTRTejAwRVJPckhQaXA5T09wZ1Fj?=
 =?utf-8?B?bUhXb2FKa2ZZR3QrSUVoNUI3RHlVU2phMDl0d002MTVUOU80RjBUd3hCeCsy?=
 =?utf-8?B?U0EzbHYrT0pkVEpiRUZrRHhyU2krUGhkSnBIL3Y0YkJ0TWI5a3hqTnFuMVcy?=
 =?utf-8?B?RjY3bDJBejd0OFdQaVYxTFM2ZnUveUxIK3hIOVk2eXU1ck9kWEJSS1VxTjVJ?=
 =?utf-8?B?TGx5OWhVUzdRWDlZczdMTllkOWxYRXpsS2dncVl0cU9OcFRPRDZQSkZuekxL?=
 =?utf-8?B?T0tTT3AvZHg4NDRzWGI2bVdSNGl5WmpYUDlwVlhVdmhEa3pPMlVYUHd6RjBI?=
 =?utf-8?B?YzMzTGxhSzNlR0MzL0dORGVIeDl6cjlkditlSWJsREd2aWZKeEpsU1V5WkVD?=
 =?utf-8?B?YUVzWjRaMGo5bnhWM29HQ3FLRjlYSmZ5OTZOam1ZN2hqbnNTQ2RoRlgwYmJ3?=
 =?utf-8?B?VDcwb2xyclUyVEJWSmdpVlJDeC9YQlprelpYZ0dhd0lMbktYR0k1MHBLSU9x?=
 =?utf-8?B?alJCb0NGS0pKcmhmL04xNE9xd25PNzUzaHZwTXFlVVRHczcxUi9zVnFER1R4?=
 =?utf-8?B?UTBLNWVRaWNqLzhnczViSUFsTnNyalh6Q0FhaVh0YTNpNUhWK1BtY2QwOWd2?=
 =?utf-8?B?UUxnUDQ2U0N0WGVpWDN0S0dHZEt4Z3ZZTjJuL1RoU0w4cXpuSlhtVTVkYWZH?=
 =?utf-8?B?djd3UzM0V2F4dVhtQUk0K2RRM0tDVW84NkJRVHRlVEFFdUVhS1hSM1pPU0JG?=
 =?utf-8?B?TW9yQzRtbjFuczRCamhuSzFKWEs5YklqaDlyL1RqL2FmSUw0bXFlaEk3QWkx?=
 =?utf-8?B?U3lra05lc2FzNnB6dmtWeHJpSW9MOUJaWTRzMXluVXFhRkdXbmZyRGVzZHcx?=
 =?utf-8?B?RElUTDltb3dDR3ljQ0hxSzFpd3g5N3V6M1M3RHdrSHVKSzNNNmFoN09POXBX?=
 =?utf-8?B?azdEdG9aOWN5NklXM3NROW5NOWk5L3IvNC9oSHlKVFd4TkhPdEo4c3BnM3Zy?=
 =?utf-8?B?Wi9ZaHpKK0QvSDgwQ1hET2JLTGZDRk5NUDZuMjU3S2JlNlJuVCtEUzkzeDJC?=
 =?utf-8?B?eFZWU1ZHSGJJQkNtaUZQa0ZNRnMzZWtGMGF1a1cwSHZvUXRLV0YxVlF5djBK?=
 =?utf-8?B?UEZxVDN6bFd6NDdIM2lhSnczVGhBWmJOQ3JSUXJpRCtRQnlENXJSZitkY2lF?=
 =?utf-8?B?RFcxV2pLMnFMTWZ3Tmw5azA2TGNMdmFXNXlrK21lcWxjbWhDNjRQV0xlMW5u?=
 =?utf-8?B?UUZkRWtBbEJRa2kydEJndWcvbmM5Nkd5OUsvRndmdEhnd2V6SG1BRUN2bFps?=
 =?utf-8?B?dUNueVF5V1FTTmZrNlRhcTdGeWlrKzVXQ20rUEpuUllFYVhsaHQwK2ZJdkJD?=
 =?utf-8?B?cmhUT3hEalByWUtVZ0x2bFNNNkJPUHdSNG90STROajVmZk5wcHp2eTllL2Jn?=
 =?utf-8?B?RTRNbW1LbGpjWFVFN3Q2a1d3U2pJQnZ0RnJxek5hWmI3bDREbEdSYUVjZEY2?=
 =?utf-8?B?aVVoRUU3OS8veUJoQnFHUFQzRmtUWVpWYVlBOGxhRjJBV0dtTmRPcyt5Mnh3?=
 =?utf-8?B?QjFWTDJRcUNCN3ZwU2pOc1dVM1d5QnlNZTdjSzQzb2lzQXNpdVFZNGtUWTVO?=
 =?utf-8?B?K2ZQMkhvSDloNnlVcUZndUlGNTlhUW41MmRVejR1dGpPLzZkb0NlaDd4WHZm?=
 =?utf-8?B?a1g5R2NPb3ZzK3BlNURaTEhQSEwyUXpWYzZIQWxIN2ZnY1Z1a0tXY0pyYW5N?=
 =?utf-8?B?aGQrczMvWEdOTlpVaDJqUlZKZ3YySEl1bWs0SHZlR2dvOEt4NER4UjJXd2tL?=
 =?utf-8?B?VGFXaWQxSGJOL29jME5zSm11Q09PN3RiaGZHTzNNbEZNQThSa1J0Qlc5SWw1?=
 =?utf-8?B?ZllYV2NBS2Q3U01IUnpqMXlHeXd1UmM4N0RBMzlCK0d1MWkya1liWnhaNGla?=
 =?utf-8?Q?KRpLKCE3VOSax5IvwkztgYd1A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20367c2b-35e2-49d7-f631-08da63b8d49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 03:44:31.7844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gr5crY4/Ur7RfYKVM4WgpyqzLRi87Vg9MXaC24ejfsBOcQkf1Q0xw+9njsPtomxiZrW3wOiGk8oFPQSPHiwHpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Feng, 
 Kenneth" <Kenneth.Feng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

R29vZCBwb2ludC4gV2Ugc2hvdWxkIGxpbWl0IGl0IGluIEJBQ08gb25seSBvbmNlIGFuIEFTSUMg
c3VwcG9ydHMgQk9DTyBhbmQgQkFDTyB0b2dldGhlci4NCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hl
ckBnbWFpbC5jb20+IA0KU2VudDogTW9uZGF5LCBKdWx5IDExLCAyMDIyIDExOjI5IFBNDQpUbzog
Q2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KQ2M6IGFtZC1nZnggbGlzdCA8YW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
PjsgTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVh
bkBhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQpTdWJqZWN0
OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogc2tpcCBTTVUgRlcgcmVsb2FkaW5nIGluIHJ1
bnBtIEJBQ08gY2FzZQ0KDQpPbiBNb24sIEp1bCAxMSwgMjAyMiBhdCA5OjU4IEFNIEd1Y2h1biBD
aGVuIDxndWNodW4uY2hlbkBhbWQuY29tPiB3cm90ZToNCj4NCj4gU01VIGlzIGFsd2F5cyBhbGl2
ZSwgc28gaXQncyBmaW5lIHRvIHNraXAgU01VIEZXIHJlbG9hZGluZyB3aGVuIHJ1bnBtIA0KPiBy
ZXN1bWVkIGZyb20gQkFDTywgdGhpcyBjYW4gYXZvaWQgc29tZSByYWNlIGlzc3VlcyB3aGVuIHJl
c3VtaW5nIFNNVSANCj4gRlcuDQo+DQo+IFN1Z2dlc3RlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1
YW5AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFt
ZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5j
IHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyANCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gaW5kZXggZTk0MTFjMjhk
ODhiLi45ZjE3MjM1YmFiODMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wc3AuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMNCj4gQEAgLTIzNDgsNiArMjM0OCwxMiBAQCBzdGF0aWMgaW50IHBzcF9sb2FkX3Nt
dV9mdyhzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
JmFkZXYtPmZpcm13YXJlLnVjb2RlW0FNREdQVV9VQ09ERV9JRF9TTUNdOw0KPiAgICAgICAgIHN0
cnVjdCBhbWRncHVfcmFzICpyYXMgPSBwc3AtPnJhc19jb250ZXh0LnJhczsNCj4NCj4gKyAgICAg
ICAvKiBTa2lwIFNNVSBGVyByZWxvYWRpbmcgaW4gY2FzZSBvZiB1c2luZyBCQUNPIGZvciBydW5w
bSwNCj4gKyAgICAgICAgKiBhcyBTTVUgaXMgYWx3YXlzIGFsaXZlLg0KPiArICAgICAgICAqLw0K
PiArICAgICAgIGlmIChhZGV2LT5pbl9ydW5wbSAmJiBhbWRncHVfYXNpY19zdXBwb3J0c19iYWNv
KGFkZXYpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQoNCldoYXQgaXMgYW4gYXNpYyBz
dXBwb3J0cyBib3RoIEJBQ08gYW5kIEJPQ08/ICBJIHRoaW5rIHdlIG5lZWQgdG8gZGlmZmVyZW50
aWF0ZSBoZXJlLg0KDQpBbGV4DQoNCj4gKw0KPiAgICAgICAgIGlmICghdWNvZGUtPmZ3IHx8IGFt
ZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
DQo+IC0tDQo+IDIuMTcuMQ0KPg0K
