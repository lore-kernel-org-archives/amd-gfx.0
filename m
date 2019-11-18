Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6F4C43215
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 22:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5DC20715
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 22:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5DC20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3366E072;
	Mon, 18 Nov 2019 22:46:52 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690050.outbound.protection.outlook.com [40.107.69.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D496E072
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 22:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myqIVdda15TJxUmLAwPANZ1ZEjxvfSagUz6PMrtE0spUZ5Rv9vQIgkNx9UPQpU03FtcNsQ/Me1CBTiXVVgwz9RLX9RcqFKOeOg3+oYolidhTCgqZUH+bNsfY5UmPLYrqhzty/qTlqqcIRqdMuodbVNAzbfz8ipmG7QyWZ8VdefX3Gb7uS8dYrVT3D3yK0gVBzCf+cfg54bIuqIdLEpRYzX+TRk4TJuHfMVSa4zWwYmLR2jSiKd7x911zi0ttEDA/UUYwaTTR0kg5/IwHxEohpblAH7bvOKDwX1KKxjyGXoHBAuWj944enyyBp9TLs4PU4VvvWCknx5z5DoexXDZNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5gpdU6p0+KGcUDroLv807T6MD7uELLJFLxDlWYIEYw=;
 b=NvShqT7iSDXKG0N8T6ytkzEkCO0GQ8gRzm6xef/AvcG/PBu3QheT7BUkWqqcN05vhLsRZ4iqya4DWa1QXcUmadvVW03cxVDgpA+hq4tj32Yfci219HF79zpgQSrjvbYTj+sSYKmLP7XH7A6dpFsZI/SkWf27IN4tjOPPq+9t64PCSRtBI6+PkmyZx+Hhsi5szHK9QxJW8bkmQsP2qNz3p9oLkNX5gDNCAwGURUH6aRfkd05oixYaWg2fObqnaCtT2mcjAhzHlmlZGPe/zH6tKIRfU4xz8aQJRYPQdzkZySJCxO/Yu9il4s00siP1Jet0mYW/lGvSNYCf7h/14iTo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3529.namprd12.prod.outlook.com (20.179.71.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Mon, 18 Nov 2019 22:46:49 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 22:46:48 +0000
Subject: Re: [PATCH 2/2] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191118222435.93134-1-alex.sierra@amd.com>
 <20191118222435.93134-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f60eeb60-712f-6aa4-2660-86970b92c637@amd.com>
Date: Mon, 18 Nov 2019 17:46:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191118222435.93134-2-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ec8c3c2-8423-49c5-1eac-08d76c79324a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3529:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35296703BC99BF3DF2FEE12B924D0@DM6PR12MB3529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(478600001)(6436002)(66946007)(58126008)(229853002)(5660300002)(66066001)(6486002)(6666004)(65806001)(65956001)(99286004)(25786009)(53546011)(386003)(47776003)(23676004)(2486003)(52116002)(14444005)(6506007)(6512007)(316002)(66476007)(66556008)(76176011)(6246003)(14454004)(4001150100001)(2870700001)(26005)(7736002)(6116002)(305945005)(486006)(3846002)(186003)(36756003)(81156014)(81166006)(50466002)(8676002)(8936002)(31686004)(476003)(86362001)(31696002)(44832011)(2616005)(446003)(11346002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3529;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRQAbLGyX0CyWTzfwZnvYt2iGw6s1mvreuoCTXycNw0Cw/86hyNzorgmrCrHxGS04GQHi7ATQrXdqr0IW0sF4xk/dGw/tbySgV6JG5cRM2Sg5MY9zdrd3vwzdIdlyaXZIy+LkNLYd4F/ZFVVhGJGjoZLxgdcCxBeKvWXh4QrZQSitTFxookgsUPsFa9/MhTXnhYzwPBYvI4ZpOTAJ/Y+3iuO/mDPNgWZYlBLVpM/phJBlfTtSGRhjN42TQkIQdIh6YSI8bazJ+e1AHjV31rp6lTKVwk1tuSW7EsE+Ir3DV2bok+edIziB5wCGCSRC/2nCZAESCUl48a2ZsdrPiM9tOwySjuLOWVDq49cKTSDV2MAkmJOpWFnlLFti+wGgmE4q+j8OkAuGW32K8TCbfs0JsBb0T5GWGBhDWMAXlfBMnBY6AkO7iqhQ9RwaXzrGU/H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec8c3c2-8423-49c5-1eac-08d76c79324a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 22:46:48.8764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ULis28aWZs+oYsC//rgLIOtfhHOFpeNUybYsxUZfRGb1/NmmvtEbUxH4QF+n1MMvv3csU1M9wRgGMeoMyftqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3529
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5gpdU6p0+KGcUDroLv807T6MD7uELLJFLxDlWYIEYw=;
 b=TxXYa5GS75bZYEjEfkQGHv+X6Vn6PWKA/VwkWZbf5gY7UOCr7jyV3EWOVjNZzXbAgi71pEiSyFmYxOx6F5PRvk8Z91EgRg6lui5reMC8NVG4PUvaLoawo6zq+Mloi/WqDtJwBFmjJCT0xAqKvvL3NX34H+tNEjHNmJ/BFtXA9QE=
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
Message-ID: <20191118224645.x_7Hv3Bc4ihZSG2orJk84Ry5A-CFuZoNvJpuZytEb9Q@z>

T24gMjAxOS0xMS0xOCAxNzoyNCwgQWxleCBTaWVycmEgd3JvdGU6Cj4gT25seSBmb3IgdGhlIGRl
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
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNiArKysrKysKPiAg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gaW5kZXggZDUxYWM4NzcxYWUwLi4zNThhNGY1MGZjZmIgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0zMjA3LDYgKzMyMDcs
MTIgQEAgYm9vbCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LCB1bnNpZ25lZCBpbnQgcGFzaWQsCj4gICAJCXZhbHVlID0gYWRldi0+ZHVtbXlfcGFnZV9h
ZGRyOwo+ICAgCQlmbGFncyB8PSBBTURHUFVfUFRFX0VYRUNVVEFCTEUgfCBBTURHUFVfUFRFX1JF
QURBQkxFIHwKPiAgIAkJCUFNREdQVV9QVEVfV1JJVEVBQkxFOwo+ICsKPiArCQlpZiAodm0tPmlz
X2NvbXB1dGVfY29udGV4dCkgewo+ICsJCQkvKiBTZXR0aW5nIFBURSBmbGFncyB0byB0cmlnZ2Vy
IGEgbm8tcmV0cnktZmF1bHQgICovCj4gKwkJCWZsYWdzID0gQU1ER1BVX1BURV9FWEVDVVRBQkxF
IHwgQU1ER1BVX1BERV9QVEUgfAo+ICsJCQkJQU1ER1BVX1BURV9URjsKCkhtbSwgdGhpcyBsb29r
cyBsaWtlIHlvdSdyZSBzZXR0aW5nIGZsYWdzIHR3aWNlIGluIHRoZSBjb21wdXRlLWNhc2UuIEkg
CndhcyBhbHNvIGV4cGVjdGluZyBzb21ldGhpbmcgbW9yZSBsaWtlIHRoaXM6CgppZiAodm0tPmlz
X2NvbXB1dGVfY29udGV4dCkgewogwqDCoMKgIC4uLgp9IGVsc2UgaWYgKGFtZGdwdV92bV9mYXVs
dF9zdG9wID09IEFNREdQVV9WTV9GQVVMVF9TVE9QX05FVkVSKSB7CiDCoMKgwqAgLi4uCn0gZWxz
ZSB7CiDCoMKgwqAgLi4uCn0KCkkuZS4gZm9yIGNvbXB1dGUgY29udGV4dHMsIHdlIGRvIG91ciBj
b21wdXRlLXNwZWNpZmljIHRoaW5nLCBvdGhlcndpc2UgCnRoZSBiZWhhdmlvdXIgZGVwZW5kcyBv
biB0aGUgYW1kZ3B1X3ZtX2ZhdWx0X3N0b3Agc2V0dGluZy4KClJlZ2FyZHMsCiDCoCBGZWxpeAoK
Cj4gKwkJfQo+ICAgCX0gZWxzZSB7Cj4gICAJCS8qIExldCB0aGUgaHcgcmV0cnkgc2lsZW50bHkg
b24gdGhlIFBURSAqLwo+ICAgCQl2YWx1ZSA9IDA7Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
