Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13AEC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 20:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6899921734
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 20:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YEclHjWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6899921734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160F06E24D;
	Tue, 21 Jan 2020 20:20:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C403B6E24D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 20:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GudjQk+sEDZFWTJ8+FLxJVKv/iq0Cb/XYLGxys03UCR3Uzvufz3nYNTWSz4cEddmUJ/1sn9mnujv7iIvd5nOkYwiVKoyvYMcm3G2j73HhS/HnJjsfd8fE+K4a2NXdx+lvdPZaXGCpiic55jxazBJWydX/afZJ+5b62wzG1T6WABmqq0vivROaLlCE1phOR9iCMbfwbQ9I7jbB3kgqI3OlowRcXpHfmM1QZd/5IUnNmxjIbR03TmIXc8gNaF2y3qeGSyWahXFdO7mPOUa8DZR387IOLI0G29iNLGlEkdQig7qzsjwUZedWO0ZaiC5mt0LVfOSg8sfCOY0EFq5rfMY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nSNLe2LIumvHl6zW/DzJEabxyASuGhgDvrK8aT3lX4=;
 b=KfvoQyYwR19YMXA/lOxFBJq+ppJuQKI9nDjHUAB8VbSiWY9Q6zixlX5PuKbLRDR697f6j7rcivsdrn1vg8ezZOhzrsI9n+y8nhB8r8d+nNcj2puQvZgakDB5qVhghqXG0GN6WSJEDhbENMb6SSSoJhdBLrgGeTO6g1u6eWQ0nCXv35qWrXwO5uDzk11X5tguDaGyeFGFdB4iSVPLraC97H2LCdLsrIhrleuTchiFepAwsnajIs5g6rcMu67Igw2gULBYmGPhd/u6pA7MwbPW/T6og+gHjZAQmzKroPtr8VhsgQLGDIzbL7bFksZIdxe3rBZCNnakxpqgYdQ6WOiLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nSNLe2LIumvHl6zW/DzJEabxyASuGhgDvrK8aT3lX4=;
 b=YEclHjWf4vVzcK1lCSPHcuJMoSoLzsSSn0QEpSkXNEeV7Ee4/PSpRGEb+dxtiN0HOvn/YOz0ad6EgpwFH/14AqoP5U68kRJAQApumzZe0iUvlRVLCJIQCM/TwNxHewOlfsiko2QNEjcuNg0mIA4XP0VPP+cLjrtjWnO7bEhJRZg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3115.namprd12.prod.outlook.com (20.178.31.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 20:20:54 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 20:20:54 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu/vcn2.5: fix a bug for the 2nd vcn instance
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-2-git-send-email-James.Zhu@amd.com>
 <9a367f37-2531-3966-7904-40cbe4a290d0@amd.com>
 <afe66ec7-d2c5-c0eb-8809-54581a7139c2@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <54758868-2ed5-2994-c357-435ea28aac2b@amd.com>
Date: Tue, 21 Jan 2020 15:20:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <afe66ec7-d2c5-c0eb-8809-54581a7139c2@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::34) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTOPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 20:20:53 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac94bf12-7b75-4a7e-9c64-08d79eaf6a67
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:|DM6PR12MB3115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31159E05E3D1F44CFD63C1F5E50D0@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(31686004)(53546011)(186003)(52116002)(8936002)(498600001)(36916002)(86362001)(16526019)(8676002)(31696002)(110136005)(81156014)(26005)(2906002)(16576012)(81166006)(44832011)(956004)(6486002)(2616005)(5660300002)(36756003)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3115;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUSs/lIpA8MSrdSpnhOjegeU+pz92yfkNXPW10LCF/3o8lvoPVgwkTqW3RevgN3CCYbooI1ZCUPSxTaxB94fc7xrh6khMDMXh86p8hjm6Ao3i9XgnN5aSEdVB65QbS8CR76NUTkECq6Mba7D/4rxTHn1uJdnn8obTIE1VrMQ6ClZiaQ6pZw0r+QDiWept23iAeQc/6ZSXo9gT3P0PMrwkpzNhm7iAtM0awSqSECJCYkSq/trfNQ833s2GctfbAVsZP46nHrX7pWLUqSPQFv1W03qDDuKRK+iiCtoB3cF8AY2g8OKTfxuTOwQjdQL3ovI5k/btuYV6VgXiMuIVci09cNi2OJvS/P6v8CFGNDkPCM3j7XcdmfBUpRWymc8C+hbq/bmMy5RkZGkb23akHgzvQvs51/64RXwj7APKlIZHLZio2KgL620NfWOZMG1rtN2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac94bf12-7b75-4a7e-9c64-08d79eaf6a67
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 20:20:54.0863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/k5AS7NRr6AHpNC4iEQGO0WLKZHBsRH56xVbalmlg/BJqYLD8kpOsN7LTpQYjlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjAtMDEtMjEgMTI6NDcgcC5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+Cj4gT24gMjAyMC0w
MS0yMSAxMjoyOSBwLm0uLCBMZW8gTGl1IHdyb3RlOgo+Pgo+PiBPbiAyMDIwLTAxLTIxIDExOjE5
IGEubS4sIEphbWVzIFpodSB3cm90ZToKPj4+IEZpeCBhIGJ1ZyBmb3IgdGhlIDJuZCB2Y24gaW5z
dGFuY2UgYXQgc3RhcnQgYW5kIHN0b3AuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1
IDxKYW1lcy5aaHVAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3YyXzUuYyB8IDEyICsrKysrKysrLS0tLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNuX3YyXzUuYwo+Pj4gaW5kZXggYzM1MWQxYS4uNzQwYTI5MSAxMDA2NDQK
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKPj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKPj4+IEBAIC04OTEsOCArODkx
LDEwIEBAIHN0YXRpYyBpbnQgdmNuX3YyXzVfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+
PiAqYWRldikKPj4+IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fdmNu
X2luc3Q7ICsraSkgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT52Y24uaGFydmVz
dF9jb25maWcgJiAoMSA8PCBpKSkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRp
bnVlOwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQ
T1JUX1ZDTl9EUEcpCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdmNuX3YyXzVf
c3RhcnRfZHBnX21vZGUoYWRldiwgaSwgCj4+PiBhZGV2LT52Y24uaW5kaXJlY3Rfc3JhbSk7Cj4+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNO
X0RQRykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IHZjbl92Ml81X3N0YXJ0X2Rw
Z19tb2RlKGFkZXYsIGksIAo+Pj4gYWRldi0+dmNuLmluZGlyZWN0X3NyYW0pOwo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pgo+PiAi
ciIgaXMgbm90IGJlaW5nIGNvbnNpZGVyZWQsIGFuZCBhZnRlciB0aGUgbG9vcCwgaXQgd2lsbCBi
ZSBnb2luZyB0byAKPj4gdGhlIGNvZGUgYmVsb3csIGlzIGl0IGNvcnJlY3Q/Cj4gU2luY2UgRFBH
IG1vZGUgc3RhcnQvc3RvcCBhbHdheXMgcmV0dXJuIDAuIEkgaGF2ZSBhZGRlZCBjb2RlIHRvIHJl
dHVybiAKPiAwIGJlbG93IHVuZGVyIERQRyBtb2RlCgpUaGVuIHlvdSBzaG91bGQgbW92ZSB0aGUg
InJldHVybiAwIiBoZXJlIGluc3RlYWQgb2YgYWRkaW5nIHR3byBtb3JlIAp1bm5lY2Vzc2FyeSBs
aW5lcy4KCgo+Pgo+Pgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIGRpc2FibGUgcmVnaXN0ZXIg
YW50aS1oYW5nIG1lY2hhbmlzbSAqLwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIFdSRUczMl9QKFNP
QzE1X1JFR19PRkZTRVQoVVZELCBpLCBtbVVWRF9QT1dFUl9TVEFUVVMpLCAwLAo+Pj4gQEAgLTkw
Myw2ICs5MDUsOSBAQCBzdGF0aWMgaW50IHZjbl92Ml81X3N0YXJ0KHN0cnVjdCBhbWRncHVfZGV2
aWNlIAo+Pj4gKmFkZXYpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KFVWRCwg
aSwgbW1VVkRfU1RBVFVTLCB0bXApOwo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoCArwqDCoMKgIGlm
IChhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpCj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIDA7Cj4+PiArCj4+PiDCoMKgwqDCoMKgIC8qU1cgY2xvY2sgZ2F0aW5nICov
Cj4+PiDCoMKgwqDCoMKgIHZjbl92Ml81X2Rpc2FibGVfY2xvY2tfZ2F0aW5nKGFkZXYpOwo+Pj4g
wqAgQEAgLTEyOTQsMTAgKzEyOTksOSBAQCBzdGF0aWMgaW50IHZjbl92Ml81X3N0b3Aoc3RydWN0
IAo+Pj4gYW1kZ3B1X2RldmljZSAqYWRldikKPj4+IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8
IGFkZXYtPnZjbi5udW1fdmNuX2luc3Q7ICsraSkgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChhZGV2LT52Y24uaGFydmVzdF9jb25maWcgJiAoMSA8PCBpKSkKPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+Pj4gLQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChh
ZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpIHsKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHIgPSB2Y25fdjJfNV9zdG9wX2RwZ19tb2RlKGFkZXYsIGkpOwo+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBwb3dlcl9vZmY7Cj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb250aW51ZTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Cj4+IHNhbWUg
cHJvYmxlbSBhcyBhYm92ZSwgZG9uJ3QgZ28gdGhyb3VnaCB0aGUgY29kZSB0aGF0IGlzbid0IG5l
Y2Vzc2FyeS4KPgo+IHNob3VsZCBiZSBmaW5lIHVuZGVyIERQRyBtb2RlLgoKSXQncyBhYm91dCBj
bGVhbiBpbXBsZW1lbnRhdGlvbi4gaWYgbm90IG5lY2Vzc2FyeSwgd2h5IGRvIHdlIG5lZWQgdG8g
YWRkIAp0aGVtLgoKTGVvCgoKCj4KPiBKQW1lcwo+Cj4+Cj4+IFJlZ2FyZHMsCj4+Cj4+IExlbwo+
Pgo+Pgo+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHdhaXQgZm9yIHZjbiBpZGxlICovCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
