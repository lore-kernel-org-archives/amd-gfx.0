Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74520C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3068720767
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AiMnOeCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3068720767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0C36EBC8;
	Thu, 25 Jun 2020 15:16:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8FB6EBC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 15:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP+WBrYvkuU8VKkDcY5F6JPrUASC+Zb1yjC+hK2xtFsLvCqWP18wc92gaRLd5z/hYtHFmijEdXzYF4k27rFS/tZa/kWUkTSsBqg/IDxlHOKAC1bmEG5reh9B6lJQ2i4ipCopwfGgTpV8SeET3vyVfEomIKq86MPNd7GBuErHNAWcKJoUYT1KIFFOelmfHnRKZjkxEf/Yx6OrFSoNUPDIxOgUpcXGsTmNWB24FpxCVzsqN38KOIGDm/JfeetFsjbIMZVsrU2pZURUse3GUNHCX6alDUo0wsqpcndd1irW6xSTr93JOufEijCs1ln/nIKVX3uh01rwzCsS9lVlllMBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u21gaBoaj3lY3wsAlQl9n0JJHEyB28etTRiriRe5SXM=;
 b=Im31NMxn6RqOt7LyU2IlJdKp8IS8k2yZ6JEak0v5xi3zrqkp33Gi2Ur3nVKq6yli0L7NzleGBQurbcM+K6uAWkecz/KBdaOV4FTBZKECshK+8Vy/zWXwonUL0ZTE/ixnn5QfjAVWhW+/XqkqRzkMZvbtdVZPRGBeGQQrzKPn3Cqx9rbhLg++WHd6fR/TxEOUP64aqFGY+uHes42zHNVGjACKcsYsnxk9OKa/FSP6gHaw6Aa2yGIU931D1x5scYmrjhl37pXdJuSuZU64msQPqMZSra2Os9YPQgdoRlyuUBpeKSlCijfDJqEBwDV+3DPCLORI5veK9Ij32k/cJdfD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u21gaBoaj3lY3wsAlQl9n0JJHEyB28etTRiriRe5SXM=;
 b=AiMnOeCHEAvqN6D58lCfObgEJr538EJDvFIHDObcsqSoGJnuYrGvPyOXvjNe/P2ijVYE3MNuoPr6+0Xps0yHM7CPb+O2wX8uDC/IHmr+KtBHLU8humLj6z5IXkRK//CO4lriAukd8zN9LU6+mXN/VElMPOIqqHXN2QsjXeLUZgY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 15:16:00 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Thu, 25 Jun 2020
 15:16:00 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Let KFD use more VMIDs on Arcturus
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20200625031834.16122-1-Felix.Kuehling@amd.com>
 <20200625031834.16122-2-Felix.Kuehling@amd.com>
 <48a11576-b734-7525-dc39-c4aef67d5d35@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <77c53962-fd2e-7004-76ab-aae4580a49b9@amd.com>
Date: Thu, 25 Jun 2020 11:15:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <48a11576-b734-7525-dc39-c4aef67d5d35@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::22) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Thu, 25 Jun 2020 15:16:00 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dd640a7-59e0-4203-f1d3-08d8191aab28
X-MS-TrafficTypeDiagnostic: SA0PR12MB4511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4511EE585E006FF769A698AF92920@SA0PR12MB4511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keHW4ASvABtdfJvGq6IvCww6EMzqUQjG4Zl9zS/JvXXDjv2bi5Mb2zM97nLXttB9dVQx7l7HEuPlAOfweIMgDYm1O5bUN+tZKZ1jhOZdnDcyufyn0S92f6mPLy9OzqPkxXijyR6Exvp7pOF512A03+XADwD5htki7msGu4RWz4EuJ9VIJhqeQ6oq3LLNRWnPkVo3Uh7WKd1jKWwbIZ+ubFzwWLYnfszaB+cvYQAQhDLuPAi9anfzIXCaTU2BSDs/UJVDsIGWfF9VxnGmfjyJ1+Htc3SL7xJ/rLZYc7H+4zufX24cYcgLVhOVWill8ZmQ2qiGeUqNWcpBVTK1T8bNA4sF9hLLYPzlM+gSIa6QGiLdp5LFiGTvQUUEp2CaY1KU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(66476007)(36756003)(66556008)(186003)(86362001)(66946007)(8936002)(478600001)(16526019)(6486002)(316002)(8676002)(5660300002)(83380400001)(31696002)(26005)(2616005)(16576012)(44832011)(31686004)(2906002)(956004)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 65u2FnN4LM6qmim49Yct3Xo9bioKGLwGJxNb9MqVCYsyjeudWGdJDyqBEp5azjGEn9SyCz2/qRdPy+cbySsQK9TMcmqrlTmzG83YhaZbv0jAwmmJXJ/g8B0c9WE2J/XALJO36EMUmP/z730bUdOc18qQHBpyXwppIxdRQbU5cSIg4yEWmvWA1wdzdc3suqmdPvYANKj8n8okJgPzlgqWIrOCK1hl7i6tAKcElJsy85oRuhI6n6RNvt9KBtzcsMqOFD4QIKs4C81LkylpWSn0yam94L3KSf1zFr+cA+HGe9ltsvMQEmY2pJSgfCib1fJbV9Mr/Bl/U6PpRQvR+uFaYP2YzPPS4+EbWf1TxXFVsrYuSO/Nz+bKgj+X2GgEqo8tnhdTwzXgu5XAad8wl4xR+fBYKTbmAYoLp+qydv/VF5AdhmAtUDu4lLcRfcTbsl4X8nPPqeDgChViz+szAlX7kxOL/JXEoIVWkTv21+In8IwUlXL/Yu5vnSwRlL4uQOBq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd640a7-59e0-4203-f1d3-08d8191aab28
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 15:16:00.5555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZpYFGBHyntICf/EvTstaG4i6Xpn+A7jAR33lAQjHGd6+MPuQKenycNzYWZBgI4g/c72fqJAok29wkI2vFusMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wNi0yNSB1bSA0OjE5IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFt
IDI1LjA2LjIwIHVtIDA1OjE4IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IFdoZW4gdGhlcmUg
aXMgbm8gZ3JhcGhpY3Mgc3VwcG9ydCwgS0ZEIGNhbiB1c2UgbW9yZSBvZiB0aGUgVk1JRHMuCj4+
IEdyYXBoaWNzCj4+IFZNSURzIGFyZSBvbmx5IHVzZWQgZm9yIHZpZGVvIGRlY29kaW5nL2VuY29k
aW5nIGFuZCBwb3N0IHByb2Nlc3NpbmcuCj4+IFdpdGgKPj4gdHdvIFZDRSBlbmdpbmVzLCB0aGVy
ZSBpcyBubyByZWFzb24gdG8gcmVzZXJ2ZSBtb3JlIHRoYW4gMiBWTUlEcyBmb3IKPj4gdGhhdC4K
Pgo+IElJUkMgdGhlIGV4cGVjdGF0aW9uIGlzIHRoYXQgd2Ugc3RpbGwgdXNlIHRoZSBjb21wdXRl
IHF1ZXVlcyBmb3IgcG9zdAo+IHByb2Nlc3NpbmcgYW5kIG5vdCB0aGUgS0ZELgo+Cj4gU28gd2Ug
d2lsbCBuZWVkIGF0IGxlYXN0IFZNSURzIGZvciB0aGF0IGFzIHdlbGwuCgpDb3JyZWN0LiBQb3N0
IHByb2Nlc3NpbmcgdXNlcyBjb21wdXRlIHF1ZXVlcyBhbmQgVk1JRHMgaW4gdGhlIEdGWEhVQi4K
VkNFIHVzZXMgVk1JRHMgaW4gdGhlIE1NSFVCLiBJIGJlbGlldmUgaW4gTWVzYSB0aGV5IHVzZSB0
aGUgc2FtZSBWTQpjb250ZXh0LiBTbyBjYW4ndCB0aGV5IHNoYXJlIHRoZSBzYW1lIFZNSURzPwoK
UmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5n
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDExICsrKysrKysrLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3Y5XzAuYwo+PiBpbmRleCA2ZTEwYjQyYzU3ZTUuLjM0NzA5MjllNWI4ZSAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4+IEBAIC0xMjQ1LDEw
ICsxMjQ1LDE1IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4+
IMKgwqDCoMKgwqAgLyoKPj4gwqDCoMKgwqDCoMKgICogbnVtYmVyIG9mIFZNcwo+PiDCoMKgwqDC
oMKgwqAgKiBWTUlEIDAgaXMgcmVzZXJ2ZWQgZm9yIFN5c3RlbQo+PiAtwqDCoMKgwqAgKiBhbWRn
cHUgZ3JhcGhpY3MvY29tcHV0ZSB3aWxsIHVzZSBWTUlEcyAxLTcKPj4gLcKgwqDCoMKgICogYW1k
a2ZkIHdpbGwgdXNlIFZNSURzIDgtMTUKPj4gK8KgwqDCoMKgICogYW1kZ3B1IGdyYXBoaWNzL2Nv
bXB1dGUgd2lsbCB1c2UgVk1JRHMgMS4ubi0xCj4+ICvCoMKgwqDCoCAqIGFtZGtmZCB3aWxsIHVz
ZSBWTUlEcyBuLi4xNQo+PiArwqDCoMKgwqAgKgo+PiArwqDCoMKgwqAgKiBUaGUgZmlyc3QgS0ZE
IFZNSUQgaXMgOCBmb3IgR1BVcyB3aXRoIGdyYXBoaWNzLCAzIGZvcgo+PiArwqDCoMKgwqAgKiBj
b21wdXRlLW9ubHkgR1BVcy4gT24gY29tcHV0ZS1vbmx5IEdQVXMgdGhhdCBsZWF2ZXMgMiBWTUlE
cwo+PiArwqDCoMKgwqAgKiBmb3IgdmlkZW8gcHJvY2Vzc2luZy4KPj4gwqDCoMKgwqDCoMKgICov
Cj4+IC3CoMKgwqAgYWRldi0+dm1fbWFuYWdlci5maXJzdF9rZmRfdm1pZCA9IDg7Cj4+ICvCoMKg
wqAgYWRldi0+dm1fbWFuYWdlci5maXJzdF9rZmRfdm1pZCA9Cj4+ICvCoMKgwqDCoMKgwqDCoCBh
ZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9BUkNUVVJVUyA/IDMgOiA4Owo+PiDCoCDCoMKgwqDCoMKg
IGFtZGdwdV92bV9tYW5hZ2VyX2luaXQoYWRldik7Cj4+IMKgIAo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
