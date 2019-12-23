Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F974C2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D8420643
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 19:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EFA3oSu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D8420643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB9D89AEB;
	Mon, 23 Dec 2019 19:34:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04CE489AEB
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 19:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrNn6u5XrcbS9JqUWEsD4E7OJrTWtzm+QZNHZdBFrVzXUbvdJDzlfQRsmFX/s+vvfNNC+Dgg4FV2GpSOP4vQKpd9Zf53Pp1/975KsM4hbxbw0+0B32O3dm9vvEnGlUs1eRKtSpfacqDluNi2kM9OFEaevxhB4YBotVy+YXawV5UgxcBEFE/UF6HHos4eO322Oc8DFQFe6oKfovw0WeLQRLDzSoz9Xzy+ybr2QN0lSBjGCmCNmDBK8xNE/cufU3mP0M7LqmyzdFyAjiWop6eu48hE/hbw0ewX9/Qy4iodja2X/Cd8yMqP14Ll8KZVR4nt26wCJqzPOcP2NiFdq3RPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWjJOQZANrMcM/YNMBCU8BYIZAvPKtFQl9vwHlx9Mlw=;
 b=GLBPs9Uw2Quf646lCP46iadCvnPXLi4yE2V48Nm86POe4hAMj8NaX5iOmFMPHtgOFf9W7CLAUpUW9M+7BvjWQIzC5Kf3WPGNMyWyRNdgCMer6bmmpSmZe+Ejyywx+tdGaaBzqv3AKgdP6Ii5h22qKTSY1VN+nN7ZNn/O0Qrle2omNknsRL/DJzf2I8W+BZ5V/OtnSMRaMoiNcg0HCSuNLTdg2/t9CX4ZgKJ7Jnw0LUza+I3Ugc+IYvgpVhAoq8nx23s0CQwnKfiKX2dXoSYoshH7DT3NOnvWKziYTd9GDwBaW11aZUFS6UPo7jxT6RdcIvH1/UijndxhwL6zDs5X+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWjJOQZANrMcM/YNMBCU8BYIZAvPKtFQl9vwHlx9Mlw=;
 b=EFA3oSu6BWrvurYzrP99GbKQfQNnMQNGSXva8a8mFaUEAatQr/htxeniTaovFnvSP44AabaFIZKt4+vD9YqhB1xTs+Dhl7H/GZlk/YxbRh5KaPlyR2dEgrmckcg1u0vEBI8Chbdn5y5GFSvVWbtn60DOjZSJJB7ElwlkW2ZZ/Wo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3291.namprd12.prod.outlook.com (20.179.105.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Mon, 23 Dec 2019 19:34:27 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::91d4:be0f:4691:f465]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::91d4:be0f:4691:f465%3]) with mapi id 15.20.2559.016; Mon, 23 Dec 2019
 19:34:27 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
To: Yong Zhao <yong.zhao@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20191220062442.33635-1-alex.sierra@amd.com>
 <20191220062442.33635-3-alex.sierra@amd.com>
 <41542c9c-a668-0a4b-1f3f-9b38c8e48d12@amd.com>
 <69ea408a-1f03-a6f4-34be-193bb5a17dec@amd.com>
 <e244e704-1020-6a11-705d-3a84dd2c01b5@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <dec1e07f-c4ca-a683-224b-286b1edaaeea@amd.com>
Date: Mon, 23 Dec 2019 14:34:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <e244e704-1020-6a11-705d-3a84dd2c01b5@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::37) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::37) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Mon, 23 Dec 2019 19:34:27 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b22e46c-9211-4ba2-b672-08d787df1f9d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3291:|DM6PR12MB3291:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB329193E4BBFD223CE4EED113922E0@DM6PR12MB3291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0260457E99
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(8936002)(36756003)(31696002)(45080400002)(52116002)(36916002)(478600001)(66946007)(86362001)(66476007)(8676002)(66556008)(81156014)(81166006)(16576012)(316002)(186003)(31686004)(16526019)(53546011)(44832011)(2906002)(2616005)(5660300002)(26005)(4001150100001)(966005)(956004)(6486002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3291;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qr835hgnQCtVJl4LRdjdoq/IBnmu3ZvEAYhSFRT1MUozeHZao0TFGUw+UZ1kDOkccLr6XYUSZE8cS7ShHHQ/agZSCyhWktAd1zyL/Df4aH0t6y9A5D8RnwXvDpSM+u1dbXmTS/fybxntc1dWcmBF6gs0SmU99IcRirG7frn4V/hD76gD4oX8QB7cv3i4gXQlK327lnRQK/i7YQFC0nzpJ/7UDgM0zOsYBLxpaLG9u+ZQP4QNKmrV/mXd6VLs7Vt4c1DbfDhJhkvEm2fU35VVB5txI/sE3pyXQjDJCUU1ktk65rALGj5VJ/JTF0tK6ejDZ/ursEtY21zYL4XQEsFH8UYjWBa9fG+TgYJ8dNjUbWozvm40qwkRjnb+naM9YXYe5alm44sa1rqL1Rdj1e5iFQM8Cqf7O+Nc900FzwPT9mNPx/nT+zvT1YSXiuA0BYhqNY5fTTQdtKEU1JiicRA1Hmk1/cxjkIr2tcTm4kJtNEo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b22e46c-9211-4ba2-b672-08d787df1f9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 19:34:27.6399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tTo41XWAfbjliHu4C1M6ETf34rzCRkneexVIPzhfXViv5Uzc/OwVYJP+vhETXMfjp82r98pYaJBc/9hWqLt7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3291
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

Ck9uIDIwMTktMTItMjAgNzowMSBwLm0uLCBZb25nIFpoYW8gd3JvdGU6Cj4KPiBPbiAyMDE5LTEy
LTIwIDY6NTAgcC5tLiwgWW9uZyBaaGFvIHdyb3RlOgo+PiBJbmxpbmUuCj4+Cj4+IE9uIDIwMTkt
MTItMjAgNDozNSBwLm0uLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPj4+IE9uIDIwMTktMTItMjAg
MToyNCwgQWxleCBTaWVycmEgd3JvdGU6Cj4+Pj4gW1doeV0KPj4+PiBUTEIgZmx1c2ggbWV0aG9k
IGhhcyBiZWVuIGRlcHJlY2F0ZWQgdXNpbmcga2ZkMmtnZCBpbnRlcmZhY2UuCj4+Pj4gVGhpcyBp
bXBsZW1lbnRhdGlvbiBpcyBub3cgb24gdGhlIGFtZGdwdV9hbWRrZmQgQVBJLgo+Pj4+Cj4+Pj4g
W0hvd10KPj4+PiBUTEIgZmx1c2ggZnVuY3Rpb25zIG5vdyBpbXBsZW1lbnRlZCBpbiBhbWRncHVf
YW1ka2ZkLgo+Pj4+Cj4+Pj4gQ2hhbmdlLUlkOiBJYzUxY2NjZGZlNmU3MTI4OGQ3OGRhNzcyYjZl
MWI2Y2VkNzJmOGVmNwo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJy
YUBhbWQuY29tPgo+Pj4KPj4+IExvb2tzIGdvb2QgdG8gbWUuIFNlZSBteSBjb21tZW50IGFib3V0
IHRoZSBUT0RPIGlubGluZS4KPj4+Cj4+Pgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8IDMyIAo+Pj4+ICsrKysrKysrKysrKysrKysr
KysrKysKPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgg
fMKgIDIgKysKPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5j
wqDCoCB8wqAgOCArKysrLS0KPj4+PiDCoCAzIGZpbGVzIGNoYW5nZWQsIDM5IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4+Pj4gaW5kZXggZDNkYTlkZGU0ZWUxLi5iN2Y2ZTcwYzU3
NjIgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZC5jCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZC5jCj4+Pj4gQEAgLTYzNCw2ICs2MzQsMzggQEAgYm9vbCBhbWRncHVfYW1ka2ZkX2lzX2tmZF92
bWlkKHN0cnVjdCAKPj4+PiBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgdm1pZCkKPj4+PiDCoMKg
wqDCoMKgIHJldHVybiBmYWxzZTsKPj4+PiDCoCB9Cj4+Pj4gwqAgK2ludCBhbWRncHVfYW1ka2Zk
X2ZsdXNoX2dwdV90bGJfdm1pZChzdHJ1Y3Qga2dkX2RldiAqa2dkLCAKPj4+PiB1aW50MTZfdCB2
bWlkKQo+Pj4+ICt7Cj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWtnZDsKPj4+PiArwqDCoMKgIC8qIFRPRE86IGNvbmRpdGlv
biBtaXNzaW5nIGZvciBGQU1JTFkgYWJvdmUgTlYgKi8KPj4+Cj4+PiBJJ20gbm90IHN1cmUgd2hh
dCdzIG1pc3NpbmcgaGVyZS4gTlYgYW5kIGFib3ZlIGRvbid0IG5lZWQgYW55IAo+Pj4gc3BlY2lh
bCB0cmVhdG1lbnQuIFNpbmNlIFNETUEgaXMgY29ubmVjdGVkIHRvIEdGWEhVQiBvbiBOViwgb25s
eSB0aGUgCj4+PiBHRlhIVUIgbmVlZHMgdG8gYmUgZmx1c2hlZC4KPj4+Cj4+PiBSZWdhcmRzLAo+
Pj4gwqAgRmVsaXgKPj4+Cj4+Pgo+Pj4+ICvCoMKgwqAgaWYgKGFkZXYtPmZhbWlseSA9PSBBTURH
UFVfRkFNSUxZX0FJKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGludCBpOwo+Pj4+ICsKPj4+PiAr
wqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGFkZXYtPm51bV92bWh1YnM7IGkrKykKPj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGIoYWRldiwg
dm1pZCwgaSwgMCk7Cj4+Pj4gK8KgwqDCoCB9IGVsc2Ugewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBh
bWRncHVfZ21jX2ZsdXNoX2dwdV90bGIoYWRldiwgdm1pZCwgQU1ER1BVX0dGWEhVQl8wLCAwKTsK
Pj4+PiArwqDCoMKgIH0KPj4KPj4gVGhpcyBpZiBlbHNlIGNhbiBiZSB1bmlmaWVkIGJ5Cj4+Cj4+
IGZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1fdm1odWJzOyBpKyspCj4+Cj4+IMKgwqDCoCBhbWRn
cHVfZ21jX2ZsdXNoX2dwdV90bGIoYWRldiwgdm1pZCwgaSwgMCk7Cj4+Cj4+Pj4gKwo+Pj4+ICvC
oMKgwqAgcmV0dXJuIDA7Cj4+Pj4gK30KPj4+PiArCj4+Pj4gK2ludCBhbWRncHVfYW1ka2ZkX2Zs
dXNoX2dwdV90bGJfcGFzaWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgCj4+Pj4gdWludDE2X3QgcGFz
aWQpCj4+Pj4gK3sKPj4+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0
cnVjdCBhbWRncHVfZGV2aWNlICopa2dkOwo+Pj4+ICvCoMKgwqAgdWludDMyX3QgZmx1c2hfdHlw
ZSA9IDA7Cj4+Pj4gK8KgwqDCoCBib29sIGFsbF9odWIgPSBmYWxzZTsKPj4+PiArCj4+Pj4gK8Kg
wqDCoCBpZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzICYmCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1ZFR0EyMCkKPj4+PiArwqDCoMKgwqDC
oMKgwqAgZmx1c2hfdHlwZSA9IDI7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgaWYgKGFkZXYtPmZhbWls
eSA9PSBBTURHUFVfRkFNSUxZX0FJKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBhbGxfaHViID0gdHJ1
ZTsKPj4+PiArCj4+Pj4gK8KgwqDCoCByZXR1cm4gYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiX3Bh
c2lkKGFkZXYsIHBhc2lkLCBmbHVzaF90eXBlLCAKPj4+PiBhbGxfaHViKTsKPiBUaGUgYWxsX2h1
YiBwYXJhbWV0ZXIgY2FuIGJlIGluZmVycmVkIGZyb20gbnVtX3ZtaHVicyBpbiAKPiBmbHVzaF9n
cHVfdGxiX3Bhc2lkKCksIHNvIGl0IGNhbiBiZSBvcHRpbWl6ZWQgb3V0IGhlcmUuCgpIaSBZb25n
LAoKVGhpcyBpcyBpbmNvcnJlY3QuIE5WIGhhcyB0d28gVk0gaHViczogR0ZYSFVCIGFuZCBNTUhV
Qi4gQnV0IEtGRCBkb2Vzbid0IApjYXJlIGFib3V0IE1NSFVCIG9uIE5hdmkgYmVjYXVzZSBTRE1B
IGlzIGNvbm5lY3RlZCB0byB0aGUgR0ZYSFVCLiAKVGhlcmVmb3JlIHRoZSBhbGxfaHViIHBhcmFt
ZXRlciBzaG91bGQgbm90IGJlIGJhc2VkIG9uIHRoZSBudW1fdm1odWJzLiAKV2UgbmVlZCBhIHNw
ZWNpYWwgY2FzZSBmb3IgTlYuCgpPciByYXRoZXIgdGhlIHNwZWNpYWwgY2FzZSBjb3VsZCBiZSBB
SSwgd2hlcmUgU0RNQSBpcyBub3QgY29ubmVjdGVkIHRvIApHRlhIVUIuIFNvIG9ubHkgb24gQUkg
d2UgbmVlZCB0byBmbHVzaCBhbGwgaHVicyBmb3IgS0ZEIFZNcy4KClJlZ2FyZHMsCiDCoCBGZWxp
eAoKPj4+PiArfQo+Pj4+ICsKPj4+PiDCoCBib29sIGFtZGdwdV9hbWRrZmRfaGF2ZV9hdG9taWNz
X3N1cHBvcnQoc3RydWN0IGtnZF9kZXYgKmtnZCkKPj4+PiDCoCB7Cj4+Pj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWtnZDsK
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZC5oIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4+
Pj4gaW5kZXggMDY5ZDVkMjMwODEwLi40N2IwZjI5NTdkMWYgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCj4+Pj4gQEAgLTEzNiw2ICsxMzYs
OCBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9zdWJtaXRfaWIoc3RydWN0IGtnZF9kZXYgCj4+Pj4gKmtn
ZCwgZW51bSBrZ2RfZW5naW5lX3R5cGUgZW5naW5lLAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdWludDMyX3QgKmliX2NtZCwgdWludDMyX3QgaWJfbGVuKTsKPj4+PiDC
oCB2b2lkIGFtZGdwdV9hbWRrZmRfc2V0X2NvbXB1dGVfaWRsZShzdHJ1Y3Qga2dkX2RldiAqa2dk
LCBib29sIGlkbGUpOwo+Pj4+IMKgIGJvb2wgYW1kZ3B1X2FtZGtmZF9oYXZlX2F0b21pY3Nfc3Vw
cG9ydChzdHJ1Y3Qga2dkX2RldiAqa2dkKTsKPj4+PiAraW50IGFtZGdwdV9hbWRrZmRfZmx1c2hf
Z3B1X3RsYl92bWlkKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHVpbnQxNl90IAo+Pj4+IHZtaWQpOwo+
Pj4+ICtpbnQgYW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdCBrZ2RfZGV2
ICprZ2QsIAo+Pj4+IHVpbnQxNl90IHBhc2lkKTsKPj4+PiDCoCDCoCBib29sIGFtZGdwdV9hbWRr
ZmRfaXNfa2ZkX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHUzMiAKPj4+PiB2bWlk
KTsKPj4+PiDCoCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3By
b2Nlc3MuYyAKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMK
Pj4+PiBpbmRleCA1MzZhMTUzYWM5YTQuLjI1YjkwZjcwYWVjZCAxMDA2NDQKPj4+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+Pj4+IEBAIC0zMiw2ICszMiw3IEBA
Cj4+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L21tYW4uaD4KPj4+PiDCoCAjaW5jbHVkZSA8bGludXgv
ZmlsZS5oPgo+Pj4+IMKgICNpbmNsdWRlICJhbWRncHVfYW1ka2ZkLmgiCj4+Pj4gKyNpbmNsdWRl
ICJhbWRncHUuaCIKPj4+PiDCoCDCoCBzdHJ1Y3QgbW1fc3RydWN0Owo+Pj4+IMKgIEBAIC0xMTUy
LDE2ICsxMTUzLDE3IEBAIGludCBrZmRfcmVzZXJ2ZWRfbWVtX21tYXAoc3RydWN0IGtmZF9kZXYg
Cj4+Pj4gKmRldiwgc3RydWN0IGtmZF9wcm9jZXNzICpwcm9jZXNzLAo+Pj4+IMKgIHZvaWQga2Zk
X2ZsdXNoX3RsYihzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQpCj4+Pj4gwqAgewo+Pj4+
IMKgwqDCoMKgwqAgc3RydWN0IGtmZF9kZXYgKmRldiA9IHBkZC0+ZGV2Owo+Pj4+IC3CoMKgwqAg
Y29uc3Qgc3RydWN0IGtmZDJrZ2RfY2FsbHMgKmYyZyA9IGRldi0+a2ZkMmtnZDsKPj4+PiDCoCDC
oMKgwqDCoMKgIGlmIChkZXYtPmRxbS0+c2NoZWRfcG9saWN5ID09IEtGRF9TQ0hFRF9QT0xJQ1lf
Tk9fSFdTKSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE5vdGhpbmcgdG8gZmx1c2ggdW50
aWwgYSBWTUlEIGlzIGFzc2lnbmVkLCB3aGljaAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
b25seSBoYXBwZW5zIHdoZW4gdGhlIGZpcnN0IHF1ZXVlIGlzIGNyZWF0ZWQuCj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKi8KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHBkZC0+cXBkLnZt
aWQpCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZjJnLT5pbnZhbGlkYXRlX3RsYnNfdm1p
ZChkZXYtPmtnZCwgcGRkLT5xcGQudm1pZCk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3ZtaWQoZGV2LT5rZ2QsCj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZGQtPnFwZC52
bWlkKTsKPj4+PiDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGYyZy0+
aW52YWxpZGF0ZV90bGJzKGRldi0+a2dkLCBwZGQtPnByb2Nlc3MtPnBhc2lkKTsKPj4+PiArwqDC
oMKgwqDCoMKgwqAgYW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3Bhc2lkKGRldi0+a2dkLAo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBkZC0+
cHJvY2Vzcy0+cGFzaWQpOwo+Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+IMKgIH0KPj4+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbmFt
MTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxp
c3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2Rh
dGE9MDIlN0MwMSU3Q3lvbmcuemhhbyU0MGFtZC5jb20lN0MzYTMzNjQ5ZDJhODA0OTk4ZDAwNDA4
ZDc4NWE3Nzc2ZiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2
MzcxMjQ4MjcwMDcwNTk3MjgmYW1wO3NkYXRhPWZOVHVubUFKT2J4ZmdiSkJsTldXWHVjeUg5ZXpl
ZEx2JTJCcnFuTVR6M0FpNCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+Cj4+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVk
ZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0Mw
MSU3Q3lvbmcuemhhbyU0MGFtZC5jb20lN0MzYTMzNjQ5ZDJhODA0OTk4ZDAwNDA4ZDc4NWE3Nzc2
ZiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMjQ4Mjcw
MDcwNTk3MjgmYW1wO3NkYXRhPWZOVHVubUFKT2J4ZmdiSkJsTldXWHVjeUg5ZXplZEx2JTJCcnFu
TVR6M0FpNCUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
