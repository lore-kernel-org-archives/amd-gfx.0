Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B08EC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7648220895
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7648220895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374276EAA1;
	Wed, 20 Nov 2019 17:24:26 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA536EA9D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 17:24:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUyN4tI6QCNITsIKNAUsqv7nEcSruCdD0zJRrFyOVK14xhhtANf3f5CokL/tJpc5SIzfHtPtxEdTgubWeAP03ml7koLF3AmHNiKeU49sWSDGhFQ9lqSbOKWQKoF0XDKl/aI2JcXbmqVDgRdaX17rbrZ2iQxNJswI4Dlz/mFeZkMeaDbs4MdA2blke6KC7eCHE4L7mh+eYBPTpp+zYC6p3e27wM/P/6D7J7SyLyOPPEQYHb2eQvOsVIGKB+wbOovdAo440u41AwOUJghJC6grk0WLScMQvihUm7xZkXvOF1FvXdrl2C2QTXJtU1UEjffGUEQ/1DEXOtffwAfkU4UlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1fgjU1HbPwoewhPlZuItKDOlBDoVWeszxnNojLVoL8=;
 b=kQsGnOO0tLpUlb64O37yrgnxf/KZbigwhRiBX3V8mT5SKCzFcJ0iZVcgePZBUICr8JQJpanQxawfRIUHMtJ820b4hFCigk6ZlsBXoWap0Xppgyq0AyWJBjy6pUuxwtjMRmNz8zssAPe6nErWQGVzZSXZiX6HSjlLgEUhPIsR4xpNv3NbcX8OBUzbgR9cnOAfrWgzHMhfEKn3nafxcBKLqJLE9cD2tTPFTYV2tM16/ldiyowx5WBdWcEeleId1bajo7NVXL+NLsr9OxXDwBvClL8UQBaHNcWNBNtTH2t9uWveg5AsPclJYsC5KQIIFGAPNHDxXnN292bozHPQt6KQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2584.namprd12.prod.outlook.com (52.132.139.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Wed, 20 Nov 2019 17:24:23 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 17:24:22 +0000
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: Luben Tuikov <luben.tuikov@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
 <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
 <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
 <cac7e351-dba8-125b-dc5d-b2fdec77731b@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0622cbcb-9b04-eed3-ad1e-7a40cc03c73a@amd.com>
Date: Wed, 20 Nov 2019 18:24:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <cac7e351-dba8-125b-dc5d-b2fdec77731b@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48333701-6f61-4bba-7eda-08d76dde7be1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2584:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25845E1CBE23B5FE31B9A5DE834F0@DM5PR12MB2584.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(2486003)(31686004)(53546011)(11346002)(7736002)(446003)(86362001)(316002)(31696002)(66476007)(66556008)(2906002)(76176011)(6512007)(23676004)(8676002)(186003)(2870700001)(4326008)(99286004)(14454004)(52116002)(25786009)(476003)(966005)(2616005)(486006)(6246003)(6436002)(81166006)(36756003)(478600001)(81156014)(305945005)(229853002)(6486002)(6306002)(46003)(6506007)(386003)(50466002)(14444005)(66574012)(8936002)(6666004)(5660300002)(66946007)(110136005)(58126008)(65956001)(47776003)(54906003)(65806001)(4001150100001)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2584;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3kiq/zwh+mcyAeBZJxyA0AKwwWfKJ1/CGZxWNGYBKcZIPOBC4FcJ9E1PVGhtryRaFs7OQG5p0UWGlXvc1hRK6hY33VfWLYYejGZvXSDpyVUFO6T/8RLhgGH/IId6u+Lwd34/qvMTUevIL41FwTm4UKxef5UUBKbp8eJHuGKB+1rYaFV5EvZ4SwYOziW9w2Y5bHh6JwsnLOQ2cU+WgpcxdjeV9wg/OsLsmArTzgmJ1hXFwJUtiPyHGujHS7uq/lmyin6yreNudt+Zzx+n9Cm/IqDf7+idnZ5L4fuJvFgXsMA6UZVEQolcGnsI3tPI9dLf1tWxDbp6dtog7geNQt0B694TGv2aS5y9dhkw0jeOzbaBjXYWAFJI0A4ZPwBW/WGdBDDfUFiZ9PaGwskv80AD2wRCAzvi6QLmrVI6n249Au7yBMRj7tB/VQDweDQbZjJAKvO0eKnxRV6C2sqc34qc7zuLqd6/BOunWZ/Rsf/av0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48333701-6f61-4bba-7eda-08d76dde7be1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 17:24:22.9015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSOi2p/y14DAA9xvVy2RA7w29riUZugA2LsL8WrdxnoTdTEvpPlMqfpkV5rkt/IQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2584
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1fgjU1HbPwoewhPlZuItKDOlBDoVWeszxnNojLVoL8=;
 b=16dprxLjCfScUMltjN/F6TUjtYe2XBNE3ku1Gp9h8DJyj2mI+maZoMZRnQlyjUqoCObWUidIA0In8ZgL1eGIbPtlWDcNjM9Iz/hjFpe2NXvJZNwXOWvBhfXz3RSNhP8AR4gB+Mq2HGH2gWshbQvc0u2rec9p2DxXFPrY/dKg0nI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 Aaron Liu <aaron.liu@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Huang Rui <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120172417.OWKCYdvLxIy0k5ohIXFq42XOQzKGsBut1naZ8ND_Syw@z>

QW0gMjAuMTEuMTkgdW0gMTg6MTYgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDIwLjEx
LjE5IHVtIDE3OjQ5IHNjaHJpZWIgTHViZW4gVHVpa292Ogo+PiBPbiAyMDE5LTExLTE5IDIxOjQx
LCBNYXJlayBPbMWhw6FrIHdyb3RlOgo+Pj4gT24gVHVlLCBOb3YgMTksIDIwMTkgYXQgODo1MiBQ
TSBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tIAo+Pj4gPG1haWx0bzpsdWJlbi50
dWlrb3ZAYW1kLmNvbT4+IHdyb3RlOgo+Pj4KPj4+IMKgwqDCoMKgIE9uIDIwMTktMTEtMTQgMTA6
MzQgcC5tLiwgQWFyb24gTGl1IHdyb3RlOgo+Pj4gwqDCoMKgwqAgPiBGcm9tOiBIdWFuZyBSdWkg
PHJheS5odWFuZ0BhbWQuY29tIDxtYWlsdG86cmF5Lmh1YW5nQGFtZC5jb20+Pgo+Pj4gwqDCoMKg
wqAgPgo+Pj4gwqDCoMKgwqAgPiBUbyBhbGlnbiB0aGUga2VybmVsIHVhcGkgY2hhbmdlIGZyb20g
QWxleDoKPj4+IMKgwqDCoMKgID4KPj4+IMKgwqDCoMKgID4gIkFkZCBhIGZsYWcgdG8gdGhlIEdF
TV9DUkVBVEUgaW9jdGwgdG8gY3JlYXRlIGVuY3J5cHRlZCAKPj4+IGJ1ZmZlcnMuIEJ1ZmZlcnMg
d2l0aAo+Pj4gwqDCoMKgwqAgPiB0aGlzIGZsYWcgc2V0IHdpbGwgYmUgY3JlYXRlZCB3aXRoIHRo
ZSBUTVogYml0IHNldCBpbiB0aGUgCj4+PiBQVEVzIG9yIGVuZ2luZXMKPj4+IMKgwqDCoMKgID4g
YWNjZXNzaW5nIHRoZW0uIFRoaXMgaXMgcmVxdWlyZWQgaW4gb3JkZXIgdG8gcHJvcGVybHkgYWNj
ZXNzIAo+Pj4gdGhlIGRhdGEgZnJvbSB0aGUKPj4+IMKgwqDCoMKgID4gZW5naW5lcy4iCj4+PiDC
oMKgwqDCoCA+Cj4+PiDCoMKgwqDCoCA+IFdlIHdpbGwgdXNlIEdFTV9DUkVBVEVfRU5DUllQVEVE
IGZsYWcgZm9yIHNlY3VyZSBidWZmZXIgCj4+PiBhbGxvY2F0aW9uLgo+Pj4gwqDCoMKgwqAgPgo+
Pj4gwqDCoMKgwqAgPiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29t
IAo+Pj4gPG1haWx0bzpyYXkuaHVhbmdAYW1kLmNvbT4+Cj4+PiDCoMKgwqDCoCA+IFJldmlld2Vk
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20gCj4+PiA8bWFpbHRv
OmFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Pgo+Pj4gwqDCoMKgwqAgPiAtLS0KPj4+IMKgwqDC
oMKgID7CoCBpbmNsdWRlL2RybS9hbWRncHVfZHJtLmggfCA1ICsrKysrCj4+PiDCoMKgwqDCoCA+
wqAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Pj4gwqDCoMKgwqAgPgo+Pj4gwqDC
oMKgwqAgPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIGIvaW5jbHVkZS9k
cm0vYW1kZ3B1X2RybS5oCj4+PiDCoMKgwqDCoCA+IGluZGV4IDVjMjhhYTcuLjFhOTVlMzcgMTAw
NjQ0Cj4+PiDCoMKgwqDCoCA+IC0tLSBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAo+Pj4gwqDC
oMKgwqAgPiArKysgYi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKPj4+IMKgwqDCoMKgID4gQEAg
LTE0MSw2ICsxNDEsMTEgQEAgZXh0ZXJuICJDIiB7Cj4+PiDCoMKgwqDCoCA+wqAgwqAqIHJlbGVh
c2luZyB0aGUgbWVtb3J5Cj4+PiDCoMKgwqDCoCA+wqAgwqAqLwo+Pj4gwqDCoMKgwqAgPsKgICNk
ZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9XSVBFX09OX1JFTEVBU0UgwqAoMSA8PCA5KQo+
Pj4gwqDCoMKgwqAgPiArLyogRmxhZyB0aGF0IEJPIHdpbGwgYmUgZW5jcnlwdGVkIGFuZCB0aGF0
IHRoZSBUTVogYml0IAo+Pj4gc2hvdWxkIGJlCj4+PiDCoMKgwqDCoCA+ICsgKiBzZXQgaW4gdGhl
IFBURXMgd2hlbiBtYXBwaW5nIHRoaXMgYnVmZmVyIHZpYSBHUFVWTSBvcgo+Pj4gwqDCoMKgwqAg
PiArICogYWNjZXNzaW5nIGl0IHdpdGggdmFyaW91cyBodyBibG9ja3MKPj4+IMKgwqDCoMKgID4g
KyAqLwo+Pj4gwqDCoMKgwqAgPiArI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9FTkNSWVBURUTC
oCDCoCDCoCDCoCDCoCAoMSA8PCAxMCkKPj4+Cj4+PiDCoMKgwqDCoCBTdHlsZSEKPj4+IMKgwqDC
oMKgIFRBQiBjaGFyPyEKPj4+Cj4+PiDCoMKgwqDCoCBZb3UgaGF2ZSBhIFRBQiBjaGFyIGJldHdl
ZW4gIi4uX0VOQ1JZUFRFRCIgYW5kICIoMSA8PCAxMCkiCj4+PiDCoMKgwqDCoCBEbyBOT1QgYWRk
L2luc2VydCBUQUIgY2hhcnMgaW5zdGVhZCBvZiBzcGFjZSB0byBhbGlnbiBjb2x1bm1ucyEKPj4+
IMKgwqDCoMKgIElmIHdoZW4geW91IHByZXNzIFRhYiBrZXkgYSB0YWIgaXMgaW5zZXJ0ZWQsIGFz
IG9wcG9zZWQgdG8gdGhlIAo+Pj4gbGluZQo+Pj4gwqDCoMKgwqAgaW5kZW50ZWQsIHRoZW4gRE8g
Tk9UIHVzZSB0aGlzIGVkaXRvci4KPj4+IMKgwqDCoMKgIFRoZSBUYWIga2V5IHNob3VsZCAiaW5k
ZW50IGFjY29yZGluZyB0byBtb2RlIiBieSBpbnNlcnRpbmcgVEFCIAo+Pj4gY2hhcnMuCj4+PiDC
oMKgwqDCoCBJZiB0aGUgbGluZSBpcyBhbHJlYWR5IGluZGVudGVkLCBhcyB0aGlzIG9uZSBpcywg
dGhlbiBpdCBzaG91bGQgCj4+PiBkbyBub3RoaW5nLgo+Pj4KPj4+Cj4+PiBJIGRpc2FncmVlIHdp
dGggdGhpcyAxMDAlLiBUYWJzIG9yIHNwYWNlcyBkb24ndCBtYXR0ZXIgaGVyZSBmcm9tIG15IAo+
Pj4gcGVyc3BlY3RpdmUuIEkgYWxzbyBkaXNhZ3JlZSB3aXRoIHlvdXIgbGFuZ3VhZ2UuIEl0J3Mg
b3Zlcmx5IGltcG9saXRlLgo+PiBCdXQgaXQncyB0aGUgY29kaW5nIHN0eWxlIG9mIExpbnV4OiBs
ZWFkaW5nIHRhYnMgb25seS4gVHJ5IGl0IHdpdGggCj4+IEVtYWNzIGFzIGRlc2NyaWJlZCBhbmQg
Z2l2ZW4gaW4KPj4KPj4gbGludXgvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5y
c3QKPj4KPj4gc3RhcnRpbmcgYXQgbGluZSA1ODkuIEFuZCBwcmVzcyB0aGUgVGFiIGtleSBvbiBh
biBhbHJlYWR5IGluZGVudGVkIAo+PiBsaW5lLS1ub3RoaW5nIHdpbGwgaGFwcGVuLiBMaW51eCBo
YXMgdHJhZGl0aW9uYWxseQo+PiBzaHVubmVkIGZyb20gbG9vc2UgVEFCIGNoYXJzIGluIGFscmVh
ZHkgaW5kZW50ZWQgbGluZXM6IGxlYWRpbmcgdGFicyAKPj4gb25seSBtb2RlLiBJbiBhIHByb3Bl
ciBjb2RlIGVkaXRvcgo+PiBwcmVzc2luZyB0aGUgVGFiIGtleSBvbmx5IGluZGVudHMgYWNjb3Jk
aW5nIHRvIGJ1ZmZlciBtb2RlLCBpdCAKPj4gc2hvdWxkbid0IGluc2VydCBhIFRhYiBjaGFyIHdp
bGx5LW5pbGx5Lgo+PiBQZW9wbGUgbWF5IHNldCB0aGVpciB0YWIgc3RvcHMgZGlmZmVyZW50bHkg
Zm9yIGRpZmZlcmVudCB0YWIgCj4+IHBvc2l0aW9ucyBhbmQgaW5zZXJ0aW5nIGEgdGFiIGNoYXIg
bWF5IGRpc3BsYXkKPj4gaW5jb3JyZWN0bHkuIFRoZSBtb3N0IHBvcnRhYmxlIHdheSB0byBhbGln
biBjb2x1bW5zIGluIGFuIGFscmVhZHkgCj4+IGluZGVudGVkLWFjY29yZGluZy10by1tb2RlIGxp
bmUsIGlzCj4+IHVzaW5nIHNwYWNlcy4gKE9mIGNvdXJzZSB0aGlzIGRvZXNuJ3QgbWF0dGVyIHdo
ZW4gdXNpbmcgc3BhY2VzIHRvIAo+PiBpbmRlbnQsIGJ1dCBMaW51eCB1c2VzIGhhcmQgVEFCIGNo
YXJzCj4+IHRvIGluZGVudDogbGludXgvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHls
ZS5yc3QuICh3aGljaCBhbHNvIAo+PiBzZWVtIHRvIGJlIHNldCB0byA4IGNoYXJzKSkKPj4KPj4g
SXQncyBhIGNvZGUgcmV2aWV3LCB0aGVyZSBpcyBubyAibGFuZ3VhZ2UiLgo+Cj4gV2VsbCB0aGUg
c2VjdGlvbiB5b3Ugbm90ZWQgYWxzbyBzdWdnZXN0IHRvIGVpdGhlciBnZXQgcmlkIG9mIGVtYWNz
IG9yIAo+IGNoYW5nZSBpdCB0byB1c2Ugc29tZSBzYW5lciBkZWZhdWx0IHZhbHVlcy4gV2UganVz
dCBnb3QgcmlkIG9mIGVtYWNzLgo+Cj4gUmVnYXJkaW5nIHRhYnMgYWZ0ZXIgdGhlIGluaXRpYWwg
aW5kZW50YXRpb24sIEkndmUganVzdCBkb25lIGEgcXVpY2sgCj4gZ3JlcCBhbmQgYXJvdW5kIDE0
JSBvZiBhbGwgZGVmaW5lcyB1bmRlciBpbmNsdWRlLyB1c2VzIHRoYXQgc28gSSB3b3VsZCAKPiBz
YXkgdGhhdCB0aGlzIGlzIHBlcmZlY3RseSBmaW5lLgoKRmFzdCB0eXBpbmcgd2l0aCBsYXp5IGV5
ZXMsIHRoYXQgc2hvdWxkIHJlYWQgImFyb3VuZCA3MSUgb2YgYWxsIGRlZmluZXMiLgoKU29ycnks
CkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+Pgo+PiBSZWdhcmRzLAo+
PiBMdWJlbgo+Pgo+Pj4gTWFyZWsKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
