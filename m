Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13BC2BD09
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 16:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA85D20801
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 16:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA85D20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677616F8A4;
	Thu,  5 Dec 2019 16:33:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA95C6F8A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 16:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4SLAGcW2qHwiRykSPIQsIWXfWAkavtOqtGOvKVPic+YUu+nOPY0v3Bwh5a00mAGnwkbIEBjrXQnPTJn8X5UVixQ18XhsyDoZMSAw+v/FyMHPatlJJcIxeJF5e9L6Zsq/hT+9CuJVDTZXZOBjxukqOFmTOh8XoFMxLjNl5vMXorBuHt6C6HHwyIkVPuYLldYCreRoMSE0B1h4X4v5dyZDe2EeF7Ku/CGAJtZSmFoAT4ZuOvO8m1LM4UmmLbg6QJnQd0xyXJQ674VYjP4qP4ClkEavewFmbwl5ul8/1bLlO/0uu2+778+/PrgOIpjWXH5+I1CP35WMAexDO2Lit4yMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acA3v6YQAvgV8y7BbxMdzqEjGKRYKIUhANcI7mG7IIA=;
 b=Wukiuco+oldiOucn8s+MqWuxq/feFRdkCqP0UuQBveUdTKqnPR2MWbKfg9KZXxY8u7BTu8QGDFJ9VyTxm5kJXcE91Sj3pye1EA2kdKEjzdDQye9M6foueImIFZm4MtFImstTOsp8TJzKTvSX89/I/euf4XbboXHTiY4ObqAUcqei4PV/qPUkm1ljc6SDbU0Byg6ye7nDo7ZOORqz2HW1Yce07jdDA2Gkpg330BPZlw/PAmzDYudgSr1kPxttEB88ElDcr542TDtIl0mqfNd1Jr+dUa9lZ7iVzQrSCde+WLszoe0griyB/m8b524HRzNbdQzlLqfk5UxtxjYcYQLeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3833.namprd12.prod.outlook.com (10.255.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 16:33:47 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 16:33:47 +0000
Subject: Re: [PATCH 4/5] drm/amdgpu: add VM eviction lock v2
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com, Alex.Sierra@amd.com
References: <20191205133940.3865-1-christian.koenig@amd.com>
 <20191205133940.3865-4-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <3111c8dc-fe18-fa94-72fd-41624bf4b0bf@amd.com>
Date: Thu, 5 Dec 2019 11:33:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191205133940.3865-4-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::42) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 923b1403-d9bc-40d1-6b7f-08d779a0e6ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:|DM6PR12MB3833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3833B539B82284492DFBD822925C0@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(6506007)(66476007)(66556008)(186003)(26005)(66946007)(25786009)(53546011)(2616005)(6636002)(6512007)(11346002)(305945005)(99286004)(2870700001)(58126008)(36916002)(229853002)(52116002)(6486002)(5660300002)(2906002)(316002)(86362001)(31696002)(14444005)(50466002)(14454004)(81166006)(8936002)(65956001)(76176011)(66574012)(36756003)(44832011)(478600001)(8676002)(81156014)(31686004)(23676004)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3833;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8F2L0V7WGssWqzzc8y4D0POQHQ4nNu3pNcmi+lq6FLGD8TKtCeg1KDeVxxv9QsGqkLPvjitbV3oj5IQxb45BbhoKxobQP+SpjwmDIjSEjfn3Kb6HfGVmlpgsqCL07aSo64lpk1HDlblyCmwwBpyd05gzRE+sjR6HaQgY4Hk9nZ54chRfj83vnZp/PDuYCMKY3Q3KyBp10FFZT4u0JANke1/QR4dhE9CgG4BDT0QmWzuPlnUO3nqFESKRHLSqJQqon83XxMK+roKnIxUoWTpNoadJ5KjFiipuO2RlnzjYDDdf0iLMN37JgadNCohuQMRmwa5hjhwowGHtkeIccavf8izkbA9mwOqisF2mnyxZoTVcYcj+S4PRjby0xDcGsUA1KthTM54/EGd6lTry+d8nHCg7IZax96uB9H44f61TSfKib9u6EE4ajtGbRlFcFggITjZ6SLzZxdIs8y0n9CVpr15+ABtE51H1BfL9VRQJD8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923b1403-d9bc-40d1-6b7f-08d779a0e6ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 16:33:46.9562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpJOqB04g8QEV2m49eyiPXR9TMZfns+Ezrbv701zvzwXW6ZWeHlgSx0OoMjEO8wfZUeEJlnrRHUWIarx5HhXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acA3v6YQAvgV8y7BbxMdzqEjGKRYKIUhANcI7mG7IIA=;
 b=ym3STAvpVndM2f5nL32iKSY8OsuSkQA6C6CmglFVDfOPySRZzeNnFmsV57z7ecd9ZyzChINs+irGGrU47dj9PA+r/FoJdIfGs6/exTKywIDIm7aT6kzixCxvUrpwuV7QwbyLvLTR3oBspeb8KklqTyHEFGBNPjafk8H/eWzz520=
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

T24gMjAxOS0xMi0wNSA4OjM5IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gVGhpcyBh
bGxvd3MgdG8gaW52YWxpZGF0ZSBWTSBlbnRyaWVzIHdpdGhvdXQgdGFraW5nIHRoZSByZXNlcnZh
dGlvbiBsb2NrLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKystLS0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmggfCAgNCArKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwg
MzYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gaW5kZXggMGQ3MDBlODE1NGM0Li44MzlkNmRmMzk0ZmMgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC02NTYsNyArNjU2LDcg
QEAgaW50IGFtZGdwdV92bV92YWxpZGF0ZV9wdF9ib3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+ICAgCQkJICAgICAgdm9pZCAqcGFyYW0pCj4gICB7
Cj4gICAJc3RydWN0IGFtZGdwdV92bV9ib19iYXNlICpib19iYXNlLCAqdG1wOwo+IC0JaW50IHIg
PSAwOwo+ICsJaW50IHI7Cj4gICAKPiAgIAl2bS0+YnVsa19tb3ZlYWJsZSAmPSBsaXN0X2VtcHR5
KCZ2bS0+ZXZpY3RlZCk7Cj4gICAKPiBAQCAtNjY1LDcgKzY2NSw3IEBAIGludCBhbWRncHVfdm1f
dmFsaWRhdGVfcHRfYm9zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1
X3ZtICp2bSwKPiAgIAo+ICAgCQlyID0gdmFsaWRhdGUocGFyYW0sIGJvKTsKPiAgIAkJaWYgKHIp
Cj4gLQkJCWJyZWFrOwo+ICsJCQlyZXR1cm4gcjsKPiAgIAo+ICAgCQlpZiAoYm8tPnRiby50eXBl
ICE9IHR0bV9ib190eXBlX2tlcm5lbCkgewo+ICAgCQkJYW1kZ3B1X3ZtX2JvX21vdmVkKGJvX2Jh
c2UpOwo+IEBAIC02NzgsNyArNjc4LDExIEBAIGludCBhbWRncHVfdm1fdmFsaWRhdGVfcHRfYm9z
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPiAgIAkJ
fQo+ICAgCX0KPiAgIAo+IC0JcmV0dXJuIHI7Cj4gKwltdXRleF9sb2NrKCZ2bS0+ZXZpY3Rpb25f
bG9jayk7Cj4gKwl2bS0+ZXZpY3RpbmcgPSBmYWxzZTsKPiArCW11dGV4X3VubG9jaygmdm0tPmV2
aWN0aW9uX2xvY2spOwo+ICsKPiArCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gICAvKioKPiBAQCAt
MTU1NSwxNSArMTU1OSwyNSBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGlu
ZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlpZiAoIShmbGFncyAmIEFNREdQVV9Q
VEVfVkFMSUQpKQo+ICAgCQlvd25lciA9IEFNREdQVV9GRU5DRV9PV05FUl9LRkQ7Cj4gICAKPiAr
CW11dGV4X2xvY2soJnZtLT5ldmljdGlvbl9sb2NrKTsKPiArCWlmICh2bS0+ZXZpY3RpbmcpIHsK
PiArCQlyID0gRUlOUFJPR1JFU1M7CgpOb3Qgc3VyZSBhYm91dCB0aGlzIGVycm9yIGNvZGUuIEFz
IGZhciBhcyBJIGNhbiBmaW5kLCB0aGlzIGlzIG5vcm1hbGx5IAp1c2VkIG9uIG5vbi1ibG9ja2lu
ZyBzb2NrZXRzLiBJIGZvdW5kIHRoaXMgZXhwbGFuYXRpb246IApodHRwczovL3N0YWNrb3ZlcmZs
b3cuY29tL3F1ZXN0aW9ucy84Mjc3OTcwL3doYXQtYXJlLXBvc3NpYmxlLXJlYXNvbi1mb3Itc29j
a2V0LWVycm9yLWVpbnByb2dyZXNzLWluLXNvbGFyaXMKClF1b3RlOiAic28gdGhlcmUgaXMgYW5v
dGhlciBlcnJvciBmb3Igbm9uLWJsb2NraW5nIGNvbm5lY3Q6IEVJTlBST0dSRVNTLCAKd2hpY2gg
dGVsbHMgeW91IHRoYXQgdGhlIG9wZXJhdGlvbiBpcyBpbiBwcm9ncmVzcyBhbmQgeW91IHNob3Vs
ZCBjaGVjayAKaXRzIHN0YXR1cyBsYXRlci4iCgpUaGlzIGNhbGwgaXMgbmVpdGhlciBub24tYmxv
Y2tpbmcgbm9yIGlzIHRoZSByZXF1ZXN0ZWQgcGFnZSB0YWJsZSB1cGRhdGUgCmluIHByb2dyZXNz
IHdoZW4gdGhpcyBlcnJvciBpcyByZXR1cm5lZC4gU28gSSdkIHRoaW5rIGEgYmV0dGVyIGVycm9y
IHRvIApyZXR1cm4gaGVyZSB3b3VsZCBiZSBFQlVTWS4KCk90aGVyIHRoYW4gdGhhdCwgdGhpcyBw
YXRjaCBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPgoKCj4gKwkJZ290byBlcnJvcl91bmxvY2s7Cj4gKwl9Cj4gKwo+ICAgCXIgPSB2bS0+dXBk
YXRlX2Z1bmNzLT5wcmVwYXJlKCZwYXJhbXMsIG93bmVyLCBleGNsdXNpdmUpOwo+ICAgCWlmIChy
KQo+IC0JCXJldHVybiByOwo+ICsJCWdvdG8gZXJyb3JfdW5sb2NrOwo+ICAgCj4gICAJciA9IGFt
ZGdwdV92bV91cGRhdGVfcHRlcygmcGFyYW1zLCBzdGFydCwgbGFzdCArIDEsIGFkZHIsIGZsYWdz
KTsKPiAgIAlpZiAocikKPiAtCQlyZXR1cm4gcjsKPiArCQlnb3RvIGVycm9yX3VubG9jazsKPiAg
IAo+IC0JcmV0dXJuIHZtLT51cGRhdGVfZnVuY3MtPmNvbW1pdCgmcGFyYW1zLCBmZW5jZSk7Cj4g
KwlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsKPiArCj4gK2Vy
cm9yX3VubG9jazoKPiArCW11dGV4X3VubG9jaygmdm0tPmV2aWN0aW9uX2xvY2spOwo+ICsJcmV0
dXJuIHI7Cj4gICB9Cj4gICAKPiAgIC8qKgo+IEBAIC0yNTIyLDExICsyNTM2LDE5IEBAIGJvb2wg
YW1kZ3B1X3ZtX2V2aWN0YWJsZShzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPiAgIAlpZiAoIWRtYV9y
ZXN2X3Rlc3Rfc2lnbmFsZWRfcmN1KGJvLT50Ym8uYmFzZS5yZXN2LCB0cnVlKSkKPiAgIAkJcmV0
dXJuIGZhbHNlOwo+ICAgCj4gKwkvKiBUcnkgdG8gYmxvY2sgb25nb2luZyB1cGRhdGVzICovCj4g
KwlpZiAoIW11dGV4X3RyeWxvY2soJmJvX2Jhc2UtPnZtLT5ldmljdGlvbl9sb2NrKSkKPiArCQly
ZXR1cm4gZmFsc2U7Cj4gKwo+ICAgCS8qIERvbid0IGV2aWN0IFZNIHBhZ2UgdGFibGVzIHdoaWxl
IHRoZXkgYXJlIHVwZGF0ZWQgKi8KPiAgIAlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZChib19i
YXNlLT52bS0+bGFzdF9kaXJlY3QpIHx8Cj4gLQkgICAgIWRtYV9mZW5jZV9pc19zaWduYWxlZChi
b19iYXNlLT52bS0+bGFzdF9kZWxheWVkKSkKPiArCSAgICAhZG1hX2ZlbmNlX2lzX3NpZ25hbGVk
KGJvX2Jhc2UtPnZtLT5sYXN0X2RlbGF5ZWQpKSB7Cj4gKwkJbXV0ZXhfdW5sb2NrKCZib19iYXNl
LT52bS0+ZXZpY3Rpb25fbG9jayk7Cj4gICAJCXJldHVybiBmYWxzZTsKPiArCX0KPiAgIAo+ICsJ
Ym9fYmFzZS0+dm0tPmV2aWN0aW5nID0gdHJ1ZTsKPiArCW11dGV4X3VubG9jaygmYm9fYmFzZS0+
dm0tPmV2aWN0aW9uX2xvY2spOwo+ICAgCXJldHVybiB0cnVlOwo+ICAgfQo+ICAgCj4gQEAgLTI3
NzMsNiArMjc5NSw5IEBAIGludCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sCj4gICAJdm0tPmxhc3RfZGlyZWN0ID0gZG1hX2Zl
bmNlX2dldF9zdHViKCk7Cj4gICAJdm0tPmxhc3RfZGVsYXllZCA9IGRtYV9mZW5jZV9nZXRfc3R1
YigpOwo+ICAgCj4gKwltdXRleF9pbml0KCZ2bS0+ZXZpY3Rpb25fbG9jayk7Cj4gKwl2bS0+ZXZp
Y3RpbmcgPSBmYWxzZTsKPiArCj4gICAJYW1kZ3B1X3ZtX2JvX3BhcmFtKGFkZXYsIHZtLCBhZGV2
LT52bV9tYW5hZ2VyLnJvb3RfbGV2ZWwsIGZhbHNlLCAmYnApOwo+ICAgCWlmICh2bV9jb250ZXh0
ID09IEFNREdQVV9WTV9DT05URVhUX0NPTVBVVEUpCj4gICAJCWJwLmZsYWdzICY9IH5BTURHUFVf
R0VNX0NSRUFURV9TSEFET1c7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgK
PiBpbmRleCBkOTNlYTlhZDg3OWUuLmQ1NjEzZDE4NGU5OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4gQEAgLTI0Miw2ICsyNDIsMTAgQEAgc3RydWN0IGFtZGdw
dV92bSB7Cj4gICAJLyogdHJlZSBvZiB2aXJ0dWFsIGFkZHJlc3NlcyBtYXBwZWQgKi8KPiAgIAlz
dHJ1Y3QgcmJfcm9vdF9jYWNoZWQJdmE7Cj4gICAKPiArCS8qIExvY2sgdG8gcHJldmVudCBldmlj
dGlvbiB3aGlsZSB3ZSBhcmUgdXBkYXRpbmcgcGFnZSB0YWJsZXMgKi8KPiArCXN0cnVjdCBtdXRl
eAkJZXZpY3Rpb25fbG9jazsKPiArCWJvb2wJCQlldmljdGluZzsKPiArCj4gICAJLyogQk9zIHdo
byBuZWVkcyBhIHZhbGlkYXRpb24gKi8KPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkCWV2aWN0ZWQ7Cj4g
ICAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
