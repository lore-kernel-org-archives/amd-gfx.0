Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2129FC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E194F20706
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wULnUiYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E194F20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99B26E2EA;
	Thu, 25 Jun 2020 15:43:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677126E2EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 15:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNUD+LkxuHYnbE4CnUpqUUEavcPxR8VLWzlNmV1yvQqma4pTqBQwOFP/wwn5l9hijvN0oKt5keS69/UyfUQ7F0JeIZ+GZkPwrpMrv3gJcvFnuw32kkKBR5ifa6Uco1lYUYRyW5h7VfcmBD44yct9UlWX0tI96S0Q7sdw7C4Q9FvuS8yghmGAjxFy627BCs025+s0PaxvV8eM6lns2k+N1mre5h2VN9YLn0xS1UyC07Sm+a4DKiWgJ/xUqI3S4pwtWfbSxC8dPSSnXtiZg0u3Gn6+nZD6H35MKAEh2vgJc1MApfJG2ES9PVnx6NxMavMQ07d9lvLvw8hywH4rANUUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs5vziT5hwMy3Y+S7bjvH7VXNoHvzOcKZPC4aYsFGv8=;
 b=hv5eKGOazNot9CtmnygGz08ej/RV9eWgEx76Ju89ShqyTNALSVvX2+XJjUMfFIbYEI5268nAOJv+UNopHT2X3Z87cvIUhzlVkMqYNIDFbSLIIZjudRHUFfer+LY38QpN0aellSmJyKfaRd8qP5DvEexFyLpqpaj5DAQ6LB7nmLGC/yqMXaQ+79ME47cvSHm8w8Y/6EVitWiH1CJyy2av/byj4AemAnC3+NQx8QCJ7KJETvYcIluYGxb/xZzeDXrskOutKwyZ9KxWTPQ0lNsIpDOt2NvPNt1TP8iTDE1HUb5fxN3HcQH8I3poC+dB+Fx/5OQhMkbvW4dGcuaYdkl2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs5vziT5hwMy3Y+S7bjvH7VXNoHvzOcKZPC4aYsFGv8=;
 b=wULnUiYFlf+Ow1febXKYVzg1qfGO1yRae9LfiomrcacxAG4yEc14C2Vto61uwPl+2kZzHfrdhGAirgtOCVzy6Ez6Nh/HCqG/pZZCMbIK8mkUl0YTiutFym3UJEfMpZ+i9V8ppJJZcnAiUQ1oP81vhckm4zs5SVLfOLPxF0GRmBg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 15:43:57 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Thu, 25 Jun 2020
 15:43:57 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Let KFD use more VMIDs on Arcturus
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200625031834.16122-1-Felix.Kuehling@amd.com>
 <20200625031834.16122-2-Felix.Kuehling@amd.com>
 <48a11576-b734-7525-dc39-c4aef67d5d35@gmail.com>
 <77c53962-fd2e-7004-76ab-aae4580a49b9@amd.com>
 <841359ec-a1cd-7722-55e6-182b6e2b6578@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e3261861-cec0-09da-3632-be8e25a22844@amd.com>
Date: Thu, 25 Jun 2020 11:43:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <841359ec-a1cd-7722-55e6-182b6e2b6578@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::26) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 15:43:56 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2ca4bea-8ffd-46bd-5b7c-08d8191e927f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26853F196BAA326B4EB1A7B692920@SN6PR12MB2685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJ+9+WiLOXAa4Szcrn7aIJ/SfnMIt9Q6QzGgrI3oto6FvETCy8hTN+SXACrWDFvtRvL1pwWTLJ8ztk00FenPnFt5jnkpoWyffQm45O4bvWFMNrEZxCJbEyQ69wanThViZdxjOvUwmyyv+AwCsQgR/eZYQKulvaJqC/8zgoNw+iKtfVq7Mr5aHzGqmdDyQdeXJVCEfD3+8/z1TzDtFpvFAonuoNqIQz8bfU38XCYlNPGyMd3IUW/5AhJzuxWu8cm1eCT6TgUvLGOojm45EXyFHEP5+L8XERI/VqzF2W7HBP1INEZ2AxmsgopIeBURA+PfZJKhRytp89wI1obmeuou+5Fj7u+0jpK3lqj/VnUlVF7DTjISZp2lHClu2pp7dsQq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(31696002)(26005)(316002)(31686004)(83380400001)(478600001)(2906002)(186003)(6486002)(16526019)(36756003)(52116002)(5660300002)(86362001)(8676002)(66556008)(8936002)(16576012)(44832011)(66476007)(2616005)(956004)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oMevHrTmEfnXxicKp9HNUM/00xzV883j2NzqiptvocKWAYkvr/x5xaC3i3yYrc7hGncprjZ5DWJJ2lMeiyHD+i6vn5VAwaQcN35dPPVRJocX6emPf+iG2nGWbThoAIFO43rM3AvtKsNcmI8TmOOsyquQWf2nDWD7WIiWS4iE1p1M+80RCy8XA4GJReKQO8+lfDvkCCP4Vx5znNpA1zX0jZwDa4cEeLZEUTGnsDTnHq3GO+AbRra5RrJ9eHI9eKrsQjwvnHPYla3KiETVAjflNmEmrHVv8B/t4yGrts34N729r0dTsJUSl/2UcYFdSsmzn6UASjkB0YSzJdAfFmvG9obpA5luWt4GaC5Kso7YBUoDXyDM+H42+muOjpKzUUgHzvVOw1RB+CGfmvIILHk1xIBdcfLFkNR467bCBEkrJ8EzoJ2p0EqoWeP7L5gi/Kr1m7TxHHH7fFigwvuZZ0guL524QceGmtcYYSjaqMl4tKC41jFo5vvsefL6me9bMGtJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ca4bea-8ffd-46bd-5b7c-08d8191e927f
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 15:43:57.1717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FVGAMtDTcZMWrxTNcbgwe24zYf5R9ebmvKMsspIgmjxgtW/JfuWOuK3rSYGFLoksExDPs1Ze7aiUSk5tghAiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
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

QW0gMjAyMC0wNi0yNSB1bSAxMTozOCBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBB
bSAyNS4wNi4yMCB1bSAxNzoxNSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBBbSAyMDIwLTA2
LTI1IHVtIDQ6MTkgYS5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+PiBBbSAyNS4wNi4y
MCB1bSAwNToxOCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4+IFdoZW4gdGhlcmUgaXMgbm8g
Z3JhcGhpY3Mgc3VwcG9ydCwgS0ZEIGNhbiB1c2UgbW9yZSBvZiB0aGUgVk1JRHMuCj4+Pj4gR3Jh
cGhpY3MKPj4+PiBWTUlEcyBhcmUgb25seSB1c2VkIGZvciB2aWRlbyBkZWNvZGluZy9lbmNvZGlu
ZyBhbmQgcG9zdCBwcm9jZXNzaW5nLgo+Pj4+IFdpdGgKPj4+PiB0d28gVkNFIGVuZ2luZXMsIHRo
ZXJlIGlzIG5vIHJlYXNvbiB0byByZXNlcnZlIG1vcmUgdGhhbiAyIFZNSURzIGZvcgo+Pj4+IHRo
YXQuCj4+PiBJSVJDIHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0IHdlIHN0aWxsIHVzZSB0aGUgY29t
cHV0ZSBxdWV1ZXMgZm9yIHBvc3QKPj4+IHByb2Nlc3NpbmcgYW5kIG5vdCB0aGUgS0ZELgo+Pj4K
Pj4+IFNvIHdlIHdpbGwgbmVlZCBhdCBsZWFzdCBWTUlEcyBmb3IgdGhhdCBhcyB3ZWxsLgo+PiBD
b3JyZWN0LiBQb3N0IHByb2Nlc3NpbmcgdXNlcyBjb21wdXRlIHF1ZXVlcyBhbmQgVk1JRHMgaW4g
dGhlIEdGWEhVQi4KPj4gVkNFIHVzZXMgVk1JRHMgaW4gdGhlIE1NSFVCLiBJIGJlbGlldmUgaW4g
TWVzYSB0aGV5IHVzZSB0aGUgc2FtZSBWTQo+PiBjb250ZXh0LiBTbyBjYW4ndCB0aGV5IHNoYXJl
IHRoZSBzYW1lIFZNSURzPwo+Cj4gQWghIEdvb2QgcG9pbnQsIEJ1dCB3ZSBzdGlsbCBuZWVkIGF0
IGxlYXN0IDMgVk1JRCB3aGVuIFZNSUQKPiByZXNlcnZhdGlvbiBpcyBhY3RpdmUuCgpJIGRvbid0
IGtub3cgYW55dGhpbmcgYWJvdXQgdGhhdCBWTUlEIHJlc2VydmF0aW9uIGZlYXR1cmUuIFdoYXQg
aXMgaXQKdXNlZCBmb3I/IFdobyBpcyB1c2luZyBpdD8gSG93IG1hbnkgVk1JRHMgY2FuIGJlIHJl
c2VydmVkPwoKSWYgb25lIFZNSUQgaXMgcmVzZXJ2ZWQsIHRoZXJlIHdvdWxkIHN0aWxsIGJlIG9u
ZSBWTUlEIGxlZnQgZm9yIHZpZGVvCnBvc3QgcHJvY2Vzc2luZy4gVGhhdCdzIG5vdCBpZGVhbCwg
YnV0IEkgZG9uJ3QgdGhpbmsgaXQgd291bGQgYmUgZmF0YWwuCkJ1dCBpcyBpdCBhIHJlYWxpc3Rp
YyB1c2UgY2FzZSB0aGF0IFZNSUQgcmVzZXJ2YXRpb24gYW5kIFJPQ20rdmlkZW8KcHJvY2Vzc2lu
ZyB3b3VsZCBoYXBwZW4gb24gdGhlIHNhbWUgc3lzdGVtIGF0IHRoZSBzYW1lIHRpbWU/CgpUaGFu
a3MsCsKgIEZlbGl4CgoKPgo+IEkgZG9uJ3QgdGhpbmsgeW91IGNhbiBnbyBiZWxvdyB0aGlzLgo+
Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4KPj4gUmVnYXJkcywKPj4gwqDCoCBGZWxpeAo+
Pgo+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y5XzAuYyB8IDExICsrKysrKysrLS0tCj4+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192OV8wLmMKPj4+PiBpbmRleCA2ZTEwYjQyYzU3ZTUuLjM0NzA5MjllNWI4ZSAx
MDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+Pj4+IEBAIC0x
MjQ1LDEwICsxMjQ1LDE1IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfc3dfaW5pdCh2b2lkICpoYW5k
bGUpCj4+Pj4gwqDCoMKgwqDCoMKgIC8qCj4+Pj4gwqDCoMKgwqDCoMKgwqAgKiBudW1iZXIgb2Yg
Vk1zCj4+Pj4gwqDCoMKgwqDCoMKgwqAgKiBWTUlEIDAgaXMgcmVzZXJ2ZWQgZm9yIFN5c3RlbQo+
Pj4+IC3CoMKgwqDCoCAqIGFtZGdwdSBncmFwaGljcy9jb21wdXRlIHdpbGwgdXNlIFZNSURzIDEt
Nwo+Pj4+IC3CoMKgwqDCoCAqIGFtZGtmZCB3aWxsIHVzZSBWTUlEcyA4LTE1Cj4+Pj4gK8KgwqDC
oMKgICogYW1kZ3B1IGdyYXBoaWNzL2NvbXB1dGUgd2lsbCB1c2UgVk1JRHMgMS4ubi0xCj4+Pj4g
K8KgwqDCoMKgICogYW1ka2ZkIHdpbGwgdXNlIFZNSURzIG4uLjE1Cj4+Pj4gK8KgwqDCoMKgICoK
Pj4+PiArwqDCoMKgwqAgKiBUaGUgZmlyc3QgS0ZEIFZNSUQgaXMgOCBmb3IgR1BVcyB3aXRoIGdy
YXBoaWNzLCAzIGZvcgo+Pj4+ICvCoMKgwqDCoCAqIGNvbXB1dGUtb25seSBHUFVzLiBPbiBjb21w
dXRlLW9ubHkgR1BVcyB0aGF0IGxlYXZlcyAyIFZNSURzCj4+Pj4gK8KgwqDCoMKgICogZm9yIHZp
ZGVvIHByb2Nlc3NpbmcuCj4+Pj4gwqDCoMKgwqDCoMKgwqAgKi8KPj4+PiAtwqDCoMKgIGFkZXYt
PnZtX21hbmFnZXIuZmlyc3Rfa2ZkX3ZtaWQgPSA4Owo+Pj4+ICvCoMKgwqAgYWRldi0+dm1fbWFu
YWdlci5maXJzdF9rZmRfdm1pZCA9Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGFkZXYtPmFzaWNfdHlw
ZSA9PSBDSElQX0FSQ1RVUlVTID8gMyA6IDg7Cj4+Pj4gwqDCoCDCoMKgwqDCoMKgIGFtZGdwdV92
bV9tYW5hZ2VyX2luaXQoYWRldik7Cj4+Pj4gwqDCoCAKPgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
