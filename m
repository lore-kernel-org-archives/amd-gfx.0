Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C454C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4047D20723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4047D20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9AE16E0A6;
	Fri, 15 Nov 2019 16:50:18 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720052.outbound.protection.outlook.com [40.107.72.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745F96E0A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+pdWQG7NSllYkq/grolAJmLM6N7p8vdnVxlDYXeC0PS9s7l/nIExqMZzTFOyY37S2j6iAAAJ073SJZqSpjQc/TtMDNC6YykMy72ntN2uXjdaLuG4T2nvr7I44wfR6J5/DxLq8FDvx9+LrVN1rl8w41Y3bdtUGZCNDAm8Zx4URLOPFamlamiXKoupEsWsUIhsJZL6Pwldu+5P9YJdcYVAbbn865Zq1eUsiUs8vH29I4Bx7BrW/UZm7wNgvP0kIzW3O8F8r5b5/Zfxmw1ZeVN3/wU+04D90Ev3EEjjGpRRKmquRGAIIBNTqConVDEbxKewCTyOzYsIdGeDC9Um9nRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPk6tBKr7wFMF5pZyoWECiaNho5go7IEQvDyGVcIITA=;
 b=kNWTfrw67QysvsqqeDSZlxdZ/BRTExxNabuSDlMI8JVv4P0P3tDk5gkTbfmLNaTOX+a48Qeb76TLaSyq/kSnKMNOFl1bTdS5+kdwloLseUOByo8v1E9eL4dal9mQ8pwfKlslPsfD3mnTQUsY+qZ8kGi1uvT4DsIrSDI+fWm1PQHfkbKT2NRMKvaov11dLLpHZLsE30lUDyayAiqvlM/fjATYcEO6ov9tcqqvG8Ilv6mt8B0QORgcQI4igyvrXvZ1/RAE34VANhR5pP5VfIitN9/rmY463mHAkJ1Xqj9DvEyna4FPQaKTjD6CVe88EhJd/DkzZ29Jg0/pnXKGdHEdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3056.namprd12.prod.outlook.com (20.178.242.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 16:50:15 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2451.023; Fri, 15 Nov 2019
 16:50:15 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/nv: add asic func for fetching vbios from rom
 directly
Thread-Topic: [PATCH] drm/amdgpu/nv: add asic func for fetching vbios from rom
 directly
Thread-Index: AQHVmli4gPFcZYaTZkyc1/nbY5uQ1qeMak+AgAAKgQ8=
Date: Fri, 15 Nov 2019 16:50:15 +0000
Message-ID: <BF41A0F4-9DA1-4E01-A053-00F616AAF7C0@amd.com>
References: <20191113192937.781329-1-alexander.deucher@amd.com>,
 <CADnq5_PsEm8mzr_5Ryj24MjdH_0CmuKBwTpHNaskfrLq0p8udw@mail.gmail.com>
In-Reply-To: <CADnq5_PsEm8mzr_5Ryj24MjdH_0CmuKBwTpHNaskfrLq0p8udw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [222.93.227.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76170ee6-a322-487a-e0fc-08d769ebe393
x-ms-traffictypediagnostic: MN2PR12MB3056:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3056C801687F22D4F7B0A00789700@MN2PR12MB3056.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(486006)(14444005)(36756003)(6916009)(81166006)(8676002)(2906002)(66446008)(64756008)(66556008)(66476007)(66946007)(91956017)(76116006)(81156014)(25786009)(1411001)(7736002)(6116002)(3846002)(14454004)(305945005)(6436002)(71190400001)(478600001)(446003)(8936002)(966005)(5660300002)(256004)(76176011)(6486002)(102836004)(53546011)(6506007)(86362001)(229853002)(54906003)(316002)(6306002)(6512007)(476003)(2616005)(33656002)(11346002)(186003)(26005)(99286004)(66066001)(71200400001)(4326008)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3056;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0dN2EGdWzh0RmNi89SHT40Z18v+jlv/QtDCWYR2C5X08iilGvPoAxqmTIgBp6b09YL1N4kbsXrhARObHphJFV+drCFJR5GRQ6pN2MSoHntcVn7e/FPd7lx70M40sfNcn+yv0B+QMXQeA+A8Mn7nGOAfdPZKriNu3PWmfRtmfkMckhXe8RfCMHsGUVDAmPu6eknlmoUmaPqWEZ6nyUyvFd17gsdDso/v8zx0yQt7Y9mD0keWqSVoRuJYUVqQTUJpytw/W6NdhEngweYzaur92XU+7ta1mgcCSzAAow0w9iCVK901bGjTyZnxb7ng+1StRVi0dhhBM/ReBD8+cbZVQid/Q4p59sAksokcTT87CCEpKp/lA1xgDbFs5fIk8d0tdW20VS+sMy2SPE4p0eYlu/IPEG0UhO09mICRHJ/mNDHMlEZbv6JBH8dQR9ALMm6D
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76170ee6-a322-487a-e0fc-08d769ebe393
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 16:50:15.1205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6ucskDpUBfRMRdfCYbSV/ujTNMSn9Wg83SdCbLGbkLHT36mqqUzNmqbslATgjQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3056
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPk6tBKr7wFMF5pZyoWECiaNho5go7IEQvDyGVcIITA=;
 b=dqQzqc1oX6oHB1gQXq3lvTNTIhhIEOzYvqhZOka3FFdYxAN+wo4aIkTmR26+POhutVSwNxf8dBNjmiQir9aC51Ch2AxplPE8rHkQFNI/3ZlNT8nKmVodF7565po/4c81e7qu6GlP2t2gBTbSpfp7ZL/XXmq9mnnDTEytYUihyMo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115165015.GEDyNZUzCEgOOPR4p1BGJQMuE-muR74fvsvXPVomuEw@z>

UmV2aWV3ZWQtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+CgpCUiwKWGlh
b2ppZQoKPiBPbiBOb3YgMTYsIDIwMTksIGF0IDEyOjEyIEFNLCBBbGV4IERldWNoZXIgPGFsZXhk
ZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4gCj4gUGluZz8KPiAKPj4gT24gV2VkLCBOb3YgMTMs
IDIwMTkgYXQgMjoyOSBQTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3Jv
dGU6Cj4+IAo+PiBOZWVkZWQgYXMgYSBmYWxsYmFjayBpZiB0aGUgdmJpb3MgY2FuJ3QgYmUgZmV0
Y2hlZCBieSBvdGhlciBtZWFucy4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4gLS0tCj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L252LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrLS0KPj4gMSBmaWxlIGNoYW5n
ZWQsIDIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L252LmMKPj4gaW5kZXggNzI4M2Q2MTk4Yjg5Li5hZDA0ZDFkNmU5YzcgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbnYuYwo+PiBAQCAtNDAsNiArNDAsNyBAQAo+PiAjaW5jbHVkZSAiZ2Mv
Z2NfMTBfMV8wX3NoX21hc2suaCIKPj4gI2luY2x1ZGUgImhkcC9oZHBfNV8wXzBfb2Zmc2V0Lmgi
Cj4+ICNpbmNsdWRlICJoZHAvaGRwXzVfMF8wX3NoX21hc2suaCIKPj4gKyNpbmNsdWRlICJzbXVp
by9zbXVpb18xMV8wXzBfb2Zmc2V0LmgiCj4+IAo+PiAjaW5jbHVkZSAic29jMTUuaCIKPj4gI2lu
Y2x1ZGUgInNvYzE1X2NvbW1vbi5oIgo+PiBAQCAtMTU2LDggKzE1NywyNyBAQCBzdGF0aWMgYm9v
bCBudl9yZWFkX2Rpc2FibGVkX2Jpb3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+IHN0
YXRpYyBib29sIG52X3JlYWRfYmlvc19mcm9tX3JvbShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTggKmJpb3MsIHUzMiBsZW5n
dGhfYnl0ZXMpCj4+IHsKPj4gLSAgICAgICAvKiBUT0RPOiB3aWxsIGltcGxlbWVudCBpdCB3aGVu
IFNNVSBoZWFkZXIgaXMgYXZhaWxhYmxlICovCj4+IC0gICAgICAgcmV0dXJuIGZhbHNlOwo+PiAr
ICAgICAgIHUzMiAqZHdfcHRyOwo+PiArICAgICAgIHUzMiBpLCBsZW5ndGhfZHc7Cj4+ICsKPj4g
KyAgICAgICBpZiAoYmlvcyA9PSBOVUxMKQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNl
Owo+PiArICAgICAgIGlmIChsZW5ndGhfYnl0ZXMgPT0gMCkKPj4gKyAgICAgICAgICAgICAgIHJl
dHVybiBmYWxzZTsKPj4gKyAgICAgICAvKiBBUFUgdmJpb3MgaW1hZ2UgaXMgcGFydCBvZiBzYmlv
cyBpbWFnZSAqLwo+PiArICAgICAgIGlmIChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpCj4+ICsg
ICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4+ICsKPj4gKyAgICAgICBkd19wdHIgPSAodTMy
ICopYmlvczsKPj4gKyAgICAgICBsZW5ndGhfZHcgPSBBTElHTihsZW5ndGhfYnl0ZXMsIDQpIC8g
NDsKPj4gKwo+PiArICAgICAgIC8qIHNldCByb20gaW5kZXggdG8gMCAqLwo+PiArICAgICAgIFdS
RUczMihTT0MxNV9SRUdfT0ZGU0VUKFNNVUlPLCAwLCBtbVJPTV9JTkRFWCksIDApOwo+PiArICAg
ICAgIC8qIHJlYWQgb3V0IHRoZSByb20gZGF0YSAqLwo+PiArICAgICAgIGZvciAoaSA9IDA7IGkg
PCBsZW5ndGhfZHc7IGkrKykKPj4gKyAgICAgICAgICAgICAgIGR3X3B0cltpXSA9IFJSRUczMihT
T0MxNV9SRUdfT0ZGU0VUKFNNVUlPLCAwLCBtbVJPTV9EQVRBKSk7Cj4+ICsKPj4gKyAgICAgICBy
ZXR1cm4gdHJ1ZTsKPj4gfQo+PiAKPj4gc3RhdGljIHN0cnVjdCBzb2MxNV9hbGxvd2VkX3JlZ2lz
dGVyX2VudHJ5IG52X2FsbG93ZWRfcmVhZF9yZWdpc3RlcnNbXSA9IHsKPj4gLS0KPj4gMi4yMy4w
Cj4+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
