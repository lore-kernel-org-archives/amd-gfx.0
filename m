Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2FDC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04321206D5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04321206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71A06EE90;
	Wed, 13 Nov 2019 22:51:43 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820054.outbound.protection.outlook.com [40.107.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827C76EE90
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZobaFI/684pq7dNL5QVfAmH+Bofh2bZYQEhg5CAgvg8OyKuFedYQQ/lhmRcoPLK/Eps4Hhl1eM1mo/DxYPgSsMnUg8xiEaXR1UKNJeuEPZRS9j5+QWZQbHKC02v7p2QPuEZYxwu9zpobeE8xlr1cyaa0KT1+z3IVeC6/aCDSgZyz2r+18HylBqckk6G44MmY7ORVUdtJUZpEzcw8AKa6txQSoq/TudZ6N1Lb0s4DF/HeFWBRGU82+Lu0hqxAK1BqijUwzJORynz2f5o6fM+ud9vLs+16uA1zF7tXE3g6lFB/C8dXIblqd0awggUZFAzMnlY//XKJUWO/I/DhfLUmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fNaKbCUrL01wWxhf63ZvqQ5ey/W8FvZjo9Qm74XRsg=;
 b=idfTmertPPxc2GG7/pcfbE1IHsGQXyTjWIBO5J24SB0pMH25/fM11TrApg3QdLP1U7StNKZ6s/WPOGrFbbB+xDSWDNJWhmRwPxD0orQ+GL+c3cBe9DZpdpaDUZqsXbQXpZJOVpe5i4KfXtYQ9Cif30GFxNdroXr42eqxFwnihThoKVt2oALPWnK8nYrxlANqTDDzj/pi7giZo2hcwuDxF9PpkH2MtQTGoAy8DRhJ/vZczPfioKHldR9wBe2LCSE+Zl3ZZxzGPa22esroaifDOfo68HfIVOhdf4EIym1l1zDy0NOpJ1Lz7inDB50pWSk20ojLSft4FB9WQcZEbP2iPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3277.namprd12.prod.outlook.com (20.179.82.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 22:51:39 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 22:51:39 +0000
Subject: Re: [PATCH] drm/amdkfd: Rename kfd_kernel_queue_*.c to
 kfd_packet_manager_*.c
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191113225008.31160-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <14494f35-cc5d-0588-ea8d-8861fbd40ab0@amd.com>
Date: Wed, 13 Nov 2019 17:51:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191113225008.31160-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::29) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfcdb0a8-f005-4058-3094-08d7688c0b8a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3277189671692A782C3A679392760@MN2PR12MB3277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(81166006)(8936002)(81156014)(31696002)(3846002)(86362001)(316002)(305945005)(6486002)(6116002)(6512007)(50466002)(2906002)(6436002)(8676002)(99286004)(5660300002)(66946007)(36756003)(66476007)(66556008)(58126008)(4001150100001)(76176011)(65956001)(478600001)(2486003)(23676004)(36916002)(52116002)(65806001)(66066001)(14454004)(7736002)(229853002)(47776003)(25786009)(31686004)(26005)(2616005)(476003)(446003)(11346002)(6246003)(186003)(6506007)(53546011)(230700001)(44832011)(486006)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3277;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tqf949+u4P12b1g6kcO2ZlAERTx0rdYGgF/TaD+HzBb2UboGvHdERTR0Roy+si8Nl2NSYsJoeluW+HkeFAjyj81NsYHVBPL1Z1PEkGWtWMpc9Ax9iS3zs2pvEEYRUlpshFfB/D7HeC9aKLoNZjSj4VYjjhP0Obh2xWrKOzooUZwgC1bBdtpQ7pWQh02WvKXP2Szljz6SyPTiwLA4Lo9zGxRF3GXE5kCMx5JrLzNPDlADmI/ZyUtMHoO2cwDJGtx/zi4vQazCGqlOIFlFK0ysP5Ili93siWoVs9nkwV/6cwE8gJ1CaNCd9Rwm8xsvjGwbhITy6H2hoUwrCefp8kIxu/tENrQBwvJDrmsseXZpBGYmaDgWr2Sfcz/BTDrJ/0+T6vqP01IInUUq6ZQZ/NRGqviIeTDFUB/tqG7VtYFcP3PI5jDG6DN1G3kbH4zW+JlN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcdb0a8-f005-4058-3094-08d7688c0b8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 22:51:39.6359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX6BLnIZOdVUOvFVEtyKFmh6v+RLO9Ojy9tJVRvuqj/CMZX+GO3U7OIO7QpPSZsR68Av/1Oy+USu66LUECHs3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3277
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fNaKbCUrL01wWxhf63ZvqQ5ey/W8FvZjo9Qm74XRsg=;
 b=FXJY9muFXx2dzW0PwzbAVpVAMxf1c3M+iGl/ocvoN23DHdf7DrTJSYPex8JCm21tW5JRma+Fm7XOkrqb6of0yKG2YU2YTGPHzyKZavn/CTAcZzLBF6nxZfxrfu7goBB/+ltC7wGmOyDwkWRyfAzHCkDg/+o09+2T930jVBtxdu0=
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
Message-ID: <20191113225138.FqHECII0gaRteCi6KVgvcZqo--8dh9QK8081i6hWsuw@z>

T24gMjAxOS0xMS0xMyA1OjUwIHAubS4sIFlvbmcgWmhhbyB3cm90ZToKPiBBZnRlciB0aGUgcmVj
ZW50IGNsZWFudXAsIHRoZSBmdW5jdGlvbmFsaXRpZXMgcHJvdmlkZWQgYnkgdGhlIHByZXZpb3Vz
Cj4ga2ZkX2tlcm5lbF9xdWV1ZV8qLmMgYXJlIGFjdHVhbGx5IGFsbCBwYWNrZXQgbWFuYWdlciBy
ZWxhdGVkLiBTbyByZW5hbWUKPiB0aGVtIHRvIHJlZmxlY3QgdGhhdC4KPgo+IENoYW5nZS1JZDog
STY1NDRjY2IzOGRhODI3Yzc0NzU0NGMwNzg3YWE5NDlkZjIwZWRiYjAKPiBTaWduZWQtb2ZmLWJ5
OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNCArKy0tCj4g
ICAuLi4vYW1ka2ZkL3trZmRfa2VybmVsX3F1ZXVlX3Y5LmMgPT4ga2ZkX3BhY2tldF9tYW5hZ2Vy
X3Y5LmN9IHwgMAo+ICAgLi4uL2FtZGtmZC97a2ZkX2tlcm5lbF9xdWV1ZV92aS5jID0+IGtmZF9w
YWNrZXRfbWFuYWdlcl92aS5jfSB8IDAKPiAgIDMgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+ICAgcmVuYW1lIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L3trZmRfa2VybmVsX3F1ZXVlX3Y5LmMgPT4ga2ZkX3BhY2tldF9tYW5hZ2VyX3Y5LmN9ICgxMDAl
KQo+ICAgcmVuYW1lIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL3trZmRfa2VybmVsX3F1ZXVl
X3ZpLmMgPT4ga2ZkX3BhY2tldF9tYW5hZ2VyX3ZpLmN9ICgxMDAlKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL01ha2VmaWxlIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQvTWFrZWZpbGUKPiBpbmRleCBmOTNhMTYzNzIzMjUuLjYxNDc0NjI3YTMyYyAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9NYWtlZmlsZQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL01ha2VmaWxlCj4gQEAgLTM4LDkgKzM4LDkgQEAgQU1E
S0ZEX0ZJTEVTCTo9ICQoQU1ES0ZEX1BBVEgpL2tmZF9tb2R1bGUubyBcCj4gICAJCSQoQU1ES0ZE
X1BBVEgpL2tmZF9tcWRfbWFuYWdlcl92OS5vIFwKPiAgIAkJJChBTURLRkRfUEFUSCkva2ZkX21x
ZF9tYW5hZ2VyX3YxMC5vIFwKPiAgIAkJJChBTURLRkRfUEFUSCkva2ZkX2tlcm5lbF9xdWV1ZS5v
IFwKPiAtCQkkKEFNREtGRF9QQVRIKS9rZmRfa2VybmVsX3F1ZXVlX3ZpLm8gXAo+IC0JCSQoQU1E
S0ZEX1BBVEgpL2tmZF9rZXJuZWxfcXVldWVfdjkubyBcCj4gICAJCSQoQU1ES0ZEX1BBVEgpL2tm
ZF9wYWNrZXRfbWFuYWdlci5vIFwKPiArCQkkKEFNREtGRF9QQVRIKS9rZmRfcGFja2V0X21hbmFn
ZXJfdmkubyBcCj4gKwkJJChBTURLRkRfUEFUSCkva2ZkX3BhY2tldF9tYW5hZ2VyX3Y5Lm8gXAo+
ICAgCQkkKEFNREtGRF9QQVRIKS9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLm8gXAo+ICAgCQkk
KEFNREtGRF9QQVRIKS9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIubyBcCj4gICAJCSQoQU1ES0ZE
X1BBVEgpL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlcl9jaWsubyBcCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFuYWdlcl92OS5jCj4gc2ltaWxhcml0eSBp
bmRleCAxMDAlCj4gcmVuYW1lIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tl
cm5lbF9xdWV1ZV92OS5jCj4gcmVuYW1lIHRvIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wYWNrZXRfbWFuYWdlcl92OS5jCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdmkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9wYWNrZXRfbWFuYWdlcl92aS5jCj4gc2ltaWxhcml0eSBpbmRleCAxMDAlCj4gcmVuYW1l
IGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92aS5jCj4g
cmVuYW1lIHRvIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFuYWdlcl92
aS5jCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
