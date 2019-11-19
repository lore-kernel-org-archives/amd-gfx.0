Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF75C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 16:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D9C208CC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 16:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D9C208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A06986E9A2;
	Tue, 19 Nov 2019 16:45:26 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730049.outbound.protection.outlook.com [40.107.73.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379006E9A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 16:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKQb+Ez7KZ8Yh58xXBY27qjXpTi3Oodr8sySGXrYjba5nzLcvw80pG/J0tVwJk+qlNq7fzE2pL/9Tylteuv1W+sIArzd0P2zGQetBTiWR7TZcQFvtnvg3nQRjk2i6URB8YsYUgQVl7UmtoSPneeJZR9tWF2Qpxk4hhFrtw3WndguNoVepvp7TLpcqRnnlBN0VBempcDtGrJ7tdAmgRwHq3EpW3Zplm6oYyUXajiJyb0Tv3p3Z59DrBiV3t6M55D7icerfE7TmgSFvl5nEFljnm/Nwxk6iRbi+vV1RJ5GxIgyZoOQ1d/uE1SpD/iAYlorMtbpS1lcDh8upd+97/nvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96Q5IhX9QjjOiQkraCv6LlIxVzyhvX363PZKEPmuvKU=;
 b=gKxf5H1e+rDNfBzYCbDNId84C+Thi4TBqZNtAGQdqt7X/yQAggkh1EKS66OJXyrHbFVLxrf0jYI5ETyk9ozsVJ8RZGBdZON4ABE3qTSeiFddjRh3ylHB13w9W19ME5YWr/5Q4o5fToxFe90IrIY4x/FbXOSzQ3trRZs+7UKI7bDpb8btFitI35OgxS+Gro07HnD7pKcH0TzlH+E6mWwhO4EnKFnVmg5ywB+V/QRjIUViZi7Zj7/Gm7R0HIC/oF4JnRoCXVtYl4zH+TgtuemdXlDpp5Pxxn59nRaJUIf/4Sd6F0Z5XYd8BX1F6u7CWOAvnR79FPwJ/EgshP4zI+sBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB2843.namprd12.prod.outlook.com (20.176.116.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Tue, 19 Nov 2019 16:45:22 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 16:45:22 +0000
Subject: Re: [PATCH 2/2] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191119163754.4966-1-alex.sierra@amd.com>
 <20191119163754.4966-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2b96848e-cf45-b558-e453-8a73de83d4a3@amd.com>
Date: Tue, 19 Nov 2019 11:45:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191119163754.4966-2-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 37614932-13f2-4b22-e380-08d76d0fde68
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB284351B878DAFC8A432D8600924C0@DM6PR12MB2843.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(199004)(189003)(14444005)(44832011)(6436002)(6486002)(66556008)(31696002)(66066001)(316002)(53546011)(65956001)(47776003)(6246003)(476003)(386003)(76176011)(486006)(229853002)(8936002)(11346002)(446003)(99286004)(2616005)(4001150100001)(58126008)(26005)(81156014)(81166006)(6512007)(186003)(8676002)(2870700001)(66476007)(66946007)(5660300002)(23676004)(6116002)(305945005)(52116002)(3846002)(65806001)(2486003)(86362001)(6506007)(2906002)(7736002)(6666004)(31686004)(36756003)(478600001)(14454004)(50466002)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2843;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSQPyTQZPeoFZsQkcxO3hfvGtH989cwQB4DinBE/dLMFrJ6K6cIWbzVS2nwZE7Gz1aIUBfCufqZERd907ocP8GSN8WnPganNZTLoBj8XLyGdH+JEmghvwqAp8AK3dDKaJQKR0SEuHbvqRo0kC4b9F/61Yuhi+Oxdv8vdq0Dl6V+ltfp9fk3c9Jx9xwc7nx0Ri7NHeuhfSZVfbTWdjHu0q+0MlbDYlltZAEqmrsnVVDevfjXD6mlv1UU8kDPQgZ0Y2epRBBPidtGHeKMSGilcz91Kvq8uhSCTbqmKB/ZSPiSKpV9/3hweqE8Dq21irIjoy9QOrhCY+qwJpHPd0I/6FdfFqyNFIehCYNx2MS/ApefC5YmsJTFEk+VvcPJfK9by/W5poY1z3lOj9aABhgz2XRT5eUdrwz1DosLGjSnK1PCAo8ygK3GZLtXxWFgE7v7r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37614932-13f2-4b22-e380-08d76d0fde68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 16:45:22.1546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8vJa7PipYSjdqggU9Kcbh6HOTouSfc1C2C/KZxxkaW/0mORe1EC5XkaSsmeIgJbZ3WJ2M0BkzmRlVlZgGVuRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2843
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96Q5IhX9QjjOiQkraCv6LlIxVzyhvX363PZKEPmuvKU=;
 b=jQmhd0PpADgT/prKZaHBQU/Gta/NQVbqRaG9kLmBPjup5ZSn0BnmiC9552ksYeCNWmKnmp1P0qsFz32WRjBjcPizheFcH2sqKHm2eTWDPb4+81XtQ+9qGCciuTRaLH0E7PYhwdgeBzlQSyG37cKjHQIgJuKP0RQepydMg4U6S6w=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191119164519.IOcxrQ3qI1nXqgrkE8HrEX--ZK22Cwh7hc9rCtgH6F4@z>

T24gMjAxOS0xMS0xOSAxMTozNywgQWxleCBTaWVycmEgd3JvdGU6Cj4gT25seSBmb3IgdGhlIGRl
YnVnZ2VyIHVzZSBjYXNlLgo+Cj4gW3doeV0KPiBBdm9pZCBlbmRsZXNzIHRyYW5zbGF0aW9uIHJl
dHJpZXMsIGFmdGVyIGFuIGludmFsaWQgYWRkcmVzcyBhY2Nlc3MgaGFzCj4gYmVlbiBpc3N1ZWQg
dG8gdGhlIEdQVS4gSW5zdGVhZCwgdGhlIHRyYXAgaGFuZGxlciBpcyBmb3JjZWQgdG8gZW50ZXIg
YnkKPiBnZW5lcmF0aW5nIGEgbm8tcmV0cnktZmF1bHQuCj4gQSBzX3RyYXAgaW5zdHJ1Y3Rpb24g
aXMgaW5zZXJ0ZWQgaW4gdGhlIGRlYnVnZ2VyIGNhc2UgdG8gbGV0IHRoZSB3YXZlIHRvCj4gZW50
ZXIgdHJhcCBoYW5kbGVyIHRvIHNhdmUgY29udGV4dC4KPgo+IFtob3ddCj4gSW50ZW50aW9uYWxs
eSB1c2luZyBhbiBpbnZhbGlkIGZsYWcgY29tYmluYXRpb24gKEYgYW5kIFAgc2V0IGF0IHRoZSBz
YW1lCj4gdGltZSkgdG8gdHJpZ2dlciBhIG5vLXJldHJ5LWZhdWx0LCBhZnRlciBhIHJldHJ5LWZh
dWx0IGhhcHBlbnMuIFRoaXMgaXMKPiBvbmx5IHZhbGlkIHVuZGVyIGNvbXB1dGUgY29udGV4dC4K
Pgo+IENoYW5nZS1JZDogSTQxODBjMzBlMjYzMWRjMDQwMWNiZDYxNzFmOGE2Nzc2ZTQ3MzNjOWEK
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KClRoaXMg
Y29tbWl0IGFkZHMgc29tZSB1bm5lY2Vzc2FyeSBlbXB0eSBsaW5lcy4gU2VlIGlubGluZS4gV2l0
aCB0aGF0IApmaXhlZCwgdGhlIHNlcmllcyBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5n
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKUGxlYXNlIGFsc28gZ2l2ZSBDaHJpc3RpYW4gYSBj
aGFuY2UgdG8gcmV2aWV3LgoKVGhhbmtzLAogwqAgRmVsaXgKCj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDkgKysrKysrKystCj4gICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IGQ1MWFjODc3MWFlMC4uY2QzNjE5NWZmOGJlIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMzIwMiwxMSAr
MzIwMiwxOCBAQCBib29sIGFtZGdwdV92bV9oYW5kbGVfZmF1bHQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHVuc2lnbmVkIGludCBwYXNpZCwKPiAgIAlmbGFncyA9IEFNREdQVV9QVEVfVkFM
SUQgfCBBTURHUFVfUFRFX1NOT09QRUQgfAo+ICAgCQlBTURHUFVfUFRFX1NZU1RFTTsKPiAgIAo+
IC0JaWYgKGFtZGdwdV92bV9mYXVsdF9zdG9wID09IEFNREdQVV9WTV9GQVVMVF9TVE9QX05FVkVS
KSB7Cj4gKwlpZiAodm0tPmlzX2NvbXB1dGVfY29udGV4dCkgewo+ICsJCS8qIFNldHRpbmcgUFRF
IGZsYWdzIHRvIHRyaWdnZXIgYSBuby1yZXRyeS1mYXVsdCAgKi8KPiArCQlmbGFncyA9IEFNREdQ
VV9QVEVfRVhFQ1VUQUJMRSB8IEFNREdQVV9QREVfUFRFIHwKPiArCQkJQU1ER1BVX1BURV9URjsK
PiArCQl2YWx1ZSA9IDA7Cj4gKwpVbm5lY2Vzc2FyeSBibGFuayBsaW5lLgo+ICsJfSBlbHNlIGlm
IChhbWRncHVfdm1fZmF1bHRfc3RvcCA9PSBBTURHUFVfVk1fRkFVTFRfU1RPUF9ORVZFUikgewo+
ICAgCQkvKiBSZWRpcmVjdCB0aGUgYWNjZXNzIHRvIHRoZSBkdW1teSBwYWdlICovCj4gICAJCXZh
bHVlID0gYWRldi0+ZHVtbXlfcGFnZV9hZGRyOwo+ICAgCQlmbGFncyB8PSBBTURHUFVfUFRFX0VY
RUNVVEFCTEUgfCBBTURHUFVfUFRFX1JFQURBQkxFIHwKPiAgIAkJCUFNREdQVV9QVEVfV1JJVEVB
QkxFOwo+ICsKVW5uZWNlc3NhcnkgYmxhbmsgbGluZS4KPiAgIAl9IGVsc2Ugewo+ICAgCQkvKiBM
ZXQgdGhlIGh3IHJldHJ5IHNpbGVudGx5IG9uIHRoZSBQVEUgKi8KPiAgIAkJdmFsdWUgPSAwOwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
