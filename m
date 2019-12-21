Return-Path: <SRS0=QHOg=2L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DCCC43603
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Dec 2019 00:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBC82070C
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Dec 2019 00:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="shrEbYmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBC82070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26726E17C;
	Sat, 21 Dec 2019 00:01:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD916E17C
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Dec 2019 00:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOT1prnQEHShumxiBmopi6pv7QUmklbfpNIYAPPNs/Jnslx2iiimTXKIYXjGQD3pzKNASuXeWxu++PbX7ta6wA8qSzhRLr7ToecHZnXTPZ9bTdjf/BWbIeFGyVd5JGfZTlKw3mHOQe7c3viUG0e6G4JF4H7PHFL02tMPbRNZFDTBBufs5G5WCZUf1DLxeQTQ7cirrir/s9j6mzL7IiUiSSqnMj1B5bycJY/8zBVpizn2EIBvhat54QUO5HqtZDKIjHtsvwX2NG6MyN6uXWya8ijZD3GW0lSwFsgywIppMN+TTaHT9zryQWtd6nwQsLOGybCSqM93yEGM5XQEvZAS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho6BIb6rZX+ntmQADuhx4L+xz/3BZ1EXuZzC2OIUCdc=;
 b=SYrkqFF+Sd1L2037BsobIYNuo98zy5/JCeSqvEmp2dbxgEf9crlLOshOX/wUErjDpeJiW5doK+2Ez6sj0v+KHb6pdUq0QApLRaVpi8lK9bNMKfjWRNjV4Ib1CwmIMwxonAoVFe28grvQilNu6GlJF/+puCsvoc8WoRqD5tH2ZLUCf8q8MK6tk8dOjUJMWrIMareT+HXd9xqCI7B3Xt2RWSDdoXHh1YnSC7ZeGsiBpsJ//PbNEP6dJlXbonAAIabrNiAkVRI05fM6A2FmmtJuIjG+ZpQaL7sG0Uo7U61gGZ4H05nAqHze+aYhBNBXHQb/f9BLmll5luWuBBvd0ZRqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho6BIb6rZX+ntmQADuhx4L+xz/3BZ1EXuZzC2OIUCdc=;
 b=shrEbYmuQYBoM181dev/kn1mx2n3cppBkPST9Ep53QcTM7jXCKjJ4WLkxAtGDi7vGoOrNV+I25rfqimoUhx5oKgwf/o2H0czUUWi/tydDhSqxLAA1n2otyck92GEiE2jABfNFQHzTtUk1bTnxHOtRDVe7MOwVhPmSmF194Nyee8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0235.namprd12.prod.outlook.com (10.174.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Sat, 21 Dec 2019 00:01:27 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2538.019; Sat, 21 Dec 2019
 00:01:26 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
From: Yong Zhao <yong.zhao@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191220062442.33635-1-alex.sierra@amd.com>
 <20191220062442.33635-3-alex.sierra@amd.com>
 <41542c9c-a668-0a4b-1f3f-9b38c8e48d12@amd.com>
 <69ea408a-1f03-a6f4-34be-193bb5a17dec@amd.com>
Message-ID: <e244e704-1020-6a11-705d-3a84dd2c01b5@amd.com>
Date: Fri, 20 Dec 2019 19:01:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <69ea408a-1f03-a6f4-34be-193bb5a17dec@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::42) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7128202c-15e6-4eb8-5251-08d785a8eca1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0235:|DM5PR1201MB0235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02357FF46AF21677AC302AD3F02C0@DM5PR1201MB0235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0258E7CCD4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(52116002)(6512007)(86362001)(31686004)(966005)(81156014)(8676002)(4001150100001)(6486002)(8936002)(45080400002)(2906002)(81166006)(66946007)(66476007)(44832011)(66556008)(316002)(2616005)(53546011)(26005)(478600001)(186003)(110136005)(6506007)(36756003)(5660300002)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0235;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYP1tjYygiIpmAHiNkaBDvEsI8Mb5noHi7wbk2KxLNGaB0RAA5EXOsCJt+y+HpgoacyBU3EglOh7XJz+TZ+0p26SRVRUi4XF/7C48a+aZyV8d1d9Ph9YdYMxyHDG+gEZIMHfprLpXMbYBR572cPz0q+QzbTZjBzN1C60WWE1DP8YFDYrm6dwwm5fMnMNs1/5gnPkgSQp4SwvkjyofWzUjqGRLix6QCUPu7qRPaAvixekcRJJH1Ga23Q9Kj4ZffDmFVUZ6M/fxy9MvO1F8X7eL+BiysL0lMfk6MMuHitJJkMTJVUHig98bHzl60PmkyZVjfi9QVn+3Ie7Cm4eE+9arPfbYJk6Hruyw8CNj8YS0agUX50xZahbaUXHkoWVyiTJiK8+cm2RXA3A0WQL7Fooe10K3SMkkldw2iKyIFRGKnwg6GKGTcJQX5gTRJIURUj/mIT+4vYW3e0+3DzRzqObcSmR13YWh9rTVT4adKubVes=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7128202c-15e6-4eb8-5251-08d785a8eca1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2019 00:01:26.8529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQW8HwoQyAe2xkNcD0BwSMTkobtx3MLRwtsRbyclNgbVczMhw0gmIzxePQugNeGT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0235
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

Ck9uIDIwMTktMTItMjAgNjo1MCBwLm0uLCBZb25nIFpoYW8gd3JvdGU6Cj4gSW5saW5lLgo+Cj4g
T24gMjAxOS0xMi0yMCA0OjM1IHAubS4sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+PiBPbiAyMDE5
LTEyLTIwIDE6MjQsIEFsZXggU2llcnJhIHdyb3RlOgo+Pj4gW1doeV0KPj4+IFRMQiBmbHVzaCBt
ZXRob2QgaGFzIGJlZW4gZGVwcmVjYXRlZCB1c2luZyBrZmQya2dkIGludGVyZmFjZS4KPj4+IFRo
aXMgaW1wbGVtZW50YXRpb24gaXMgbm93IG9uIHRoZSBhbWRncHVfYW1ka2ZkIEFQSS4KPj4+Cj4+
PiBbSG93XQo+Pj4gVExCIGZsdXNoIGZ1bmN0aW9ucyBub3cgaW1wbGVtZW50ZWQgaW4gYW1kZ3B1
X2FtZGtmZC4KPj4+Cj4+PiBDaGFuZ2UtSWQ6IEljNTFjY2NkZmU2ZTcxMjg4ZDc4ZGE3NzJiNmUx
YjZjZWQ3MmY4ZWY3Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFA
YW1kLmNvbT4KPj4KPj4gTG9va3MgZ29vZCB0byBtZS4gU2VlIG15IGNvbW1lbnQgYWJvdXQgdGhl
IFRPRE8gaW5saW5lLgo+Pgo+Pgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCAzMiAKPj4+ICsrKysrKysrKysrKysrKysrKysrKysKPj4+
IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaCB8wqAgMiArKwo+
Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuY8KgwqAgfMKgIDgg
KysrKy0tCj4+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZC5jCj4+PiBpbmRleCBkM2RhOWRkZTRlZTEuLmI3ZjZlNzBjNTc2MiAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+PiBAQCAtNjM0LDYg
KzYzNCwzOCBAQCBib29sIGFtZGdwdV9hbWRrZmRfaXNfa2ZkX3ZtaWQoc3RydWN0IAo+Pj4gYW1k
Z3B1X2RldmljZSAqYWRldiwgdTMyIHZtaWQpCj4+PiDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsK
Pj4+IMKgIH0KPj4+IMKgICtpbnQgYW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3ZtaWQoc3Ry
dWN0IGtnZF9kZXYgKmtnZCwgCj4+PiB1aW50MTZfdCB2bWlkKQo+Pj4gK3sKPj4+ICvCoMKgwqAg
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilrZ2Q7
Cj4+PiArwqDCoMKgIC8qIFRPRE86IGNvbmRpdGlvbiBtaXNzaW5nIGZvciBGQU1JTFkgYWJvdmUg
TlYgKi8KPj4KPj4gSSdtIG5vdCBzdXJlIHdoYXQncyBtaXNzaW5nIGhlcmUuIE5WIGFuZCBhYm92
ZSBkb24ndCBuZWVkIGFueSBzcGVjaWFsIAo+PiB0cmVhdG1lbnQuIFNpbmNlIFNETUEgaXMgY29u
bmVjdGVkIHRvIEdGWEhVQiBvbiBOViwgb25seSB0aGUgR0ZYSFVCIAo+PiBuZWVkcyB0byBiZSBm
bHVzaGVkLgo+Pgo+PiBSZWdhcmRzLAo+PiDCoCBGZWxpeAo+Pgo+Pgo+Pj4gK8KgwqDCoCBpZiAo
YWRldi0+ZmFtaWx5ID09IEFNREdQVV9GQU1JTFlfQUkpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBp
bnQgaTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVt
X3ZtaHViczsgaSsrKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dtY19mbHVz
aF9ncHVfdGxiKGFkZXYsIHZtaWQsIGksIDApOwo+Pj4gK8KgwqDCoCB9IGVsc2Ugewo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYihhZGV2LCB2bWlkLCBBTURHUFVf
R0ZYSFVCXzAsIDApOwo+Pj4gK8KgwqDCoCB9Cj4KPiBUaGlzIGlmIGVsc2UgY2FuIGJlIHVuaWZp
ZWQgYnkKPgo+IGZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1fdm1odWJzOyBpKyspCj4KPiDCoMKg
wqAgYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiKGFkZXYsIHZtaWQsIGksIDApOwo+Cj4+PiArCj4+
PiArwqDCoMKgIHJldHVybiAwOwo+Pj4gK30KPj4+ICsKPj4+ICtpbnQgYW1kZ3B1X2FtZGtmZF9m
bHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHVpbnQxNl90IAo+Pj4gcGFz
aWQpCj4+PiArewo+Pj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqKWtnZDsKPj4+ICvCoMKgwqAgdWludDMyX3QgZmx1c2hfdHlwZSA9
IDA7Cj4+PiArwqDCoMKgIGJvb2wgYWxsX2h1YiA9IGZhbHNlOwo+Pj4gKwo+Pj4gK8KgwqDCoCBp
ZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzICYmCj4+PiArwqDCoMKgwqDCoMKg
wqAgYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTIwKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGZs
dXNoX3R5cGUgPSAyOwo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAoYWRldi0+ZmFtaWx5ID09IEFNREdQ
VV9GQU1JTFlfQUkpCj4+PiArwqDCoMKgwqDCoMKgwqAgYWxsX2h1YiA9IHRydWU7Cj4+PiArCj4+
PiArwqDCoMKgIHJldHVybiBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFzaWQoYWRldiwgcGFz
aWQsIGZsdXNoX3R5cGUsIAo+Pj4gYWxsX2h1Yik7ClRoZSBhbGxfaHViIHBhcmFtZXRlciBjYW4g
YmUgaW5mZXJyZWQgZnJvbSBudW1fdm1odWJzIGluIApmbHVzaF9ncHVfdGxiX3Bhc2lkKCksIHNv
IGl0IGNhbiBiZSBvcHRpbWl6ZWQgb3V0IGhlcmUuCj4+PiArfQo+Pj4gKwo+Pj4gwqAgYm9vbCBh
bWRncHVfYW1ka2ZkX2hhdmVfYXRvbWljc19zdXBwb3J0KHN0cnVjdCBrZ2RfZGV2ICprZ2QpCj4+
PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVj
dCBhbWRncHVfZGV2aWNlICopa2dkOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaCAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5oCj4+PiBpbmRleCAwNjlkNWQyMzA4MTAuLjQ3YjBmMjk1N2QxZiAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQu
aAo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4+
PiBAQCAtMTM2LDYgKzEzNiw4IEBAIGludCBhbWRncHVfYW1ka2ZkX3N1Ym1pdF9pYihzdHJ1Y3Qg
a2dkX2RldiAqa2dkLCAKPj4+IGVudW0ga2dkX2VuZ2luZV90eXBlIGVuZ2luZSwKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgKmliX2NtZCwgdWludDMyX3Qg
aWJfbGVuKTsKPj4+IMKgIHZvaWQgYW1kZ3B1X2FtZGtmZF9zZXRfY29tcHV0ZV9pZGxlKHN0cnVj
dCBrZ2RfZGV2ICprZ2QsIGJvb2wgaWRsZSk7Cj4+PiDCoCBib29sIGFtZGdwdV9hbWRrZmRfaGF2
ZV9hdG9taWNzX3N1cHBvcnQoc3RydWN0IGtnZF9kZXYgKmtnZCk7Cj4+PiAraW50IGFtZGdwdV9h
bWRrZmRfZmx1c2hfZ3B1X3RsYl92bWlkKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHVpbnQxNl90IAo+
Pj4gdm1pZCk7Cj4+PiAraW50IGFtZGdwdV9hbWRrZmRfZmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1
Y3Qga2dkX2RldiAqa2dkLCB1aW50MTZfdCAKPj4+IHBhc2lkKTsKPj4+IMKgIMKgIGJvb2wgYW1k
Z3B1X2FtZGtmZF9pc19rZmRfdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIAo+
Pj4gdm1pZCk7Cj4+PiDCoCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3Byb2Nlc3MuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nl
c3MuYwo+Pj4gaW5kZXggNTM2YTE1M2FjOWE0Li4yNWI5MGY3MGFlY2QgMTAwNjQ0Cj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+PiBAQCAtMzIsNiArMzIsNyBA
QAo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L21tYW4uaD4KPj4+IMKgICNpbmNsdWRlIDxsaW51eC9m
aWxlLmg+Cj4+PiDCoCAjaW5jbHVkZSAiYW1kZ3B1X2FtZGtmZC5oIgo+Pj4gKyNpbmNsdWRlICJh
bWRncHUuaCIKPj4+IMKgIMKgIHN0cnVjdCBtbV9zdHJ1Y3Q7Cj4+PiDCoCBAQCAtMTE1MiwxNiAr
MTE1MywxNyBAQCBpbnQga2ZkX3Jlc2VydmVkX21lbV9tbWFwKHN0cnVjdCBrZmRfZGV2IAo+Pj4g
KmRldiwgc3RydWN0IGtmZF9wcm9jZXNzICpwcm9jZXNzLAo+Pj4gwqAgdm9pZCBrZmRfZmx1c2hf
dGxiKHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCkKPj4+IMKgIHsKPj4+IMKgwqDCoMKg
wqAgc3RydWN0IGtmZF9kZXYgKmRldiA9IHBkZC0+ZGV2Owo+Pj4gLcKgwqDCoCBjb25zdCBzdHJ1
Y3Qga2ZkMmtnZF9jYWxscyAqZjJnID0gZGV2LT5rZmQya2dkOwo+Pj4gwqAgwqDCoMKgwqDCoCBp
ZiAoZGV2LT5kcW0tPnNjaGVkX3BvbGljeSA9PSBLRkRfU0NIRURfUE9MSUNZX05PX0hXUykgewo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE5vdGhpbmcgdG8gZmx1c2ggdW50aWwgYSBWTUlEIGlz
IGFzc2lnbmVkLCB3aGljaAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBvbmx5IGhhcHBlbnMg
d2hlbiB0aGUgZmlyc3QgcXVldWUgaXMgY3JlYXRlZC4KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICovCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHBkZC0+cXBkLnZtaWQpCj4+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmMmctPmludmFsaWRhdGVfdGxic192bWlkKGRldi0+a2dkLCBwZGQt
PnFwZC52bWlkKTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9hbWRrZmRfZmx1
c2hfZ3B1X3RsYl92bWlkKGRldi0+a2dkLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZGQtPnFwZC52bWlkKTsKPj4+IMKgwqDCoMKg
wqAgfSBlbHNlIHsKPj4+IC3CoMKgwqDCoMKgwqDCoCBmMmctPmludmFsaWRhdGVfdGxicyhkZXYt
PmtnZCwgcGRkLT5wcm9jZXNzLT5wYXNpZCk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2Ft
ZGtmZF9mbHVzaF9ncHVfdGxiX3Bhc2lkKGRldi0+a2dkLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGRkLT5wcm9jZXNzLT5wYXNpZCk7Cj4+PiDC
oMKgwqDCoMKgIH0KPj4+IMKgIH0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1h
biUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDeW9uZy56aGFvJTQwYW1k
LmNvbSU3QzNhMzM2NDlkMmE4MDQ5OThkMDA0MDhkNzg1YTc3NzZmJTdDM2RkODk2MWZlNDg4NGU2
MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzEyNDgyNzAwNzA1OTcyOCZhbXA7c2RhdGE9
Zk5UdW5tQUpPYnhmZ2JKQmxOV1dYdWN5SDllemVkTHYlMkJycW5NVHozQWk0JTNEJmFtcDtyZXNl
cnZlZD0wIAo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q3lvbmcuemhhbyU0MGFtZC5jb20lN0MzYTMzNjQ5
ZDJhODA0OTk4ZDAwNDA4ZDc4NWE3Nzc2ZiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUx
ODNkJTdDMCU3QzAlN0M2MzcxMjQ4MjcwMDcwNTk3MjgmYW1wO3NkYXRhPWZOVHVubUFKT2J4Zmdi
SkJsTldXWHVjeUg5ZXplZEx2JTJCcnFuTVR6M0FpNCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
