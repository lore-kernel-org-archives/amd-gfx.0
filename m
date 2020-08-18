Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06C9C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 00:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811BE2076D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 00:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="o7RWJwFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811BE2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560F16E156;
	Tue, 18 Aug 2020 00:27:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BF36E156
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 00:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX6zYKxbrPBMqQKjpLt9cPS8MlJayoabPTzL/6OLvwepHyc3NrC8IWXd/wYGSnEOwWReA53yK3GDXISK33U0AUgtTA3oUkB8TFQnuJaXokUJhspT9PIOMe9goI32j0g9eUC2NDl4mcN1yTyGf5dRB8YFHNhOqDf46kwASm0E4DdmeieSLfmEZtsoWkViDTRgqXMX0EiBPCmF4GP6tPt8kdkY9+XoRnQSDcwmMydV3WEGFGQf5sfOxf6w99F1/W6vvzOo0GnBtKyb1WWyjpeRvXxZyJ9oQ0zhU1BdAPdUD0iExXgvmRH2tD2nUTOs8pFmVzKXiYZD75KfKrC6hzSLkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfplnF9oEpHzXjkJOWeOgUo97H7lHPasd4jD8TwPbN8=;
 b=Yk5mQLI4DYqzLd8EzjEF88ted6EVoLymVy6GIJFzdUBvQf9VjGNT0zGH6WNQL72Cxgef74tRz5J+1oePrKjDDkX/bXAPC6egXOJ97Efy8omBD4yHTC/Pe4Shs/7X2xXay00U4Scyy0v/7A1ZWowXBYoP5ZaS/yaits1PkhhPsEM5MYgafbZcFr6V4lIj563/js1vY58AN8jLoZ5SJVn6ysCKoy/9Tx/CO53xUPWrv8pSDSJ28+ZQEcUQ51kLLu0v1FwIh1yrQhHQ5ok3zaF/5WAJHpR1dd0LENPnxxts+4PE9kr82Tj0tr0kNyv9Jt0P+l0lTXJ8kA0nVHIiYOxlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfplnF9oEpHzXjkJOWeOgUo97H7lHPasd4jD8TwPbN8=;
 b=o7RWJwFYdz5nqs94b98ZKo7iSROcuyF0NR/0Bh1puTDWuWx5o6QqBxVENtK7nlzxFXMTzx6aAG13wo/z4Jk+WB1ZTT7uwwToUFc3h9Gw4ltBRjQa7Feu6wryWveWjjPKngQEqc3a0v5l8vkOp/ULuVZi0DmHBIscwXVMJn+rUao=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Tue, 18 Aug
 2020 00:27:03 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3283.027; Tue, 18 Aug 2020
 00:27:03 +0000
Subject: Re: [PATCH v2] drm/amdkfd: sparse: Fix warning in reading SDMA
 counters
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200817235812.5518-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d966d55e-175f-277f-ac1a-74c073a5e641@amd.com>
Date: Mon, 17 Aug 2020 20:27:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817235812.5518-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Tue, 18 Aug 2020 00:27:03 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 653719d4-04eb-49c1-5bf8-08d8430d6e01
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366C7FD1D6B2C6D8D279343925C0@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6yffY5X/mu1EOD0+t7nWWYa3iX48TOvAsXsZ7alHC15/jS5fZhq1CYjS9RhzXAqTt83EiNt0v/N5kFjtlJldYyJu/NDn2tdf0qhEpkdJ6Se27DYqMzvFtT8lWvwUaPK7hNyEJB1v6aY5WHOr/t3RBrLFeBYTDP+yxslktHVjI1Kyz2TI/iFH3i8qbP6VSWdN/GyZ21T9WACCFHmXQKs1GyCa9Wnk5V6hxJ5fad0vJt8jR1wqDIIue4ghbg4gdqe8l0xSrI1xIcLVfQOAaBxtAbR8+Wele9wFRjWpCg1EuBSz3QEF3CtjhEYVPSPoAeFbe5hb9B4c/uQDPHlB2Bw8/9jcPBlNFFUXn0uDpljrepwifCvqLm57Edo7ksoGfZC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(16576012)(86362001)(66476007)(66556008)(66946007)(316002)(36756003)(2906002)(26005)(52116002)(83380400001)(478600001)(2616005)(8936002)(44832011)(16526019)(6486002)(8676002)(186003)(956004)(31686004)(31696002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pgJ64VcZxqgZ4JI1amNTE8xeVNJelDu/CgystwAldcFnYrXpae2eLCdIF4QMEs1Xv7cJVNTeeLXwGwdMFbq13mp8AsKsA7o8Gmu7jpULt/B+TqmZ21ZwmSfSUjDcQ9G117qARfMmqzC1HYGtszAyxR5/ojbs04vMYcPYemSmW+n2JVyknn4GWhe/OMYtkYrDeU1pfWTAb+wdkw7bw2LQjwUtwo9aljYn2J38AoSo10iLLKGIHHiQ6TuiKc73UJrtLNq5ffX2dpDR6Rv7DmpzjrqHxya26n2SoUQhgtiGcny3HkjxUbl8GhOoBd64NaFwb4Di881yXDh267OOjDr4fKFAfyfxDP1xQcgwiNgFXpRNz24/V+PSwV3YmbKtM2rHfAc1LH1F5UahjxM6LFUnirR5WMl+uXRsbomeY00NAImECxP+XyGmS7uqjqVOKZnb7XgKIkdVIV5nr3LyYLagRV6zLwC4P9zK5bqCq1KzNmd1Fzp+FRQ/xKaw5+FitM7DD0ZjgDl3Fq3aaKmVEFmF4O+69WxFj4VIuyEygfu8EkKOrEqIwIQe+jlhEogXdknmpYXIQ0ohj+LN0jqkNa9s9BXnDFQWCEdApijda7oHSlb1sz8qOqM9hWPN62btz5iR2Hji6GAZiZNGakdBdkaL9g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653719d4-04eb-49c1-5bf8-08d8430d6e01
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 00:27:03.4162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BH5ihokIeEYCh2IPQBCZ96KfTGh59TIX+sWDG9PO1zK2zwf9d1GC6rvXJJOdI8a8DWHGkRFOk+hEOkxAIYwsiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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

U29ycnksIG1vcmUgYmlrZS1zaGVkZGluZy4KCkFtIDIwMjAtMDgtMTcgdW0gNzo1OCBwLm0uIHNj
aHJpZWIgTXVrdWwgSm9zaGk6Cj4gQWRkIF9fdXNlciBhbm5vdGF0aW9uIHRvIGZpeCByZWxhdGVk
IHNwYXJzZSB3YXJuaW5nIHdoaWxlIHJlYWRpbmcKPiBTRE1BIGNvdW50ZXJzIGZyb20gdXNlcmxh
bmQuCj4KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogTXVrdWwgSm9zaGkgPG11a3VsLmpvc2hpQGFtZC5jb20+Cj4gLS0tCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIHwg
OSArKystLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2
aWNlX3F1ZXVlX21hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZp
Y2VfcXVldWVfbWFuYWdlci5jCj4gaW5kZXggZTBlNjBiMGQwNjY5Li5lMjg5NDk2N2MzNzIgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9t
YW5hZ2VyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1
ZXVlX21hbmFnZXIuYwo+IEBAIC0xNTcsMTkgKzE1NywxNiBAQCBpbnQgcmVhZF9zZG1hX3F1ZXVl
X2NvdW50ZXIodWludDY0X3QgcV9ycHRyLCB1aW50NjRfdCAqdmFsKQo+ICB7Cj4gIAlpbnQgcmV0
Owo+ICAJdWludDY0X3QgdG1wID0gMDsKPiArCXVpbnQ2NF90IF9fdXNlciAqc2RtYV91c2FnZV9j
bnRyOwo+ICAKPiAgCWlmICghdmFsKQo+ICAJCXJldHVybiAtRUlOVkFMOwoKTWF5YmUgdGhpcyBj
aGVjayBpc24ndCBuZWVkZWQuIEJvdGggY2FsbGVycyBwYXNzIGluIHBvaW50ZXJzIHRvIGxvY2Fs
CnZhcmlhYmxlcy4gSWYgYSBjYWxsZXIgZ2V0cyB0aGF0IHdyb25nLCBob3cgbGlrZWx5IGFyZSB0
aGV5IGdvaW5nIHRvCmhhbmRsZSB0aGUgZXJyb3IgY29kZSBjb3JyZWN0bHk/CgoKPiAgCS8qCj4g
IAkgKiBTRE1BIGFjdGl2aXR5IGNvdW50ZXIgaXMgc3RvcmVkIGF0IHF1ZXVlJ3MgUlBUUiArIDB4
OCBsb2NhdGlvbi4KPiAgCSAqLwo+IC0JaWYgKCFhY2Nlc3Nfb2soKGNvbnN0IHZvaWQgX191c2Vy
ICopKHFfcnB0ciArCj4gLQkJCQkJc2l6ZW9mKHVpbnQ2NF90KSksIHNpemVvZih1aW50NjRfdCkp
KSB7Cj4gLQkJcHJfZXJyKCJDYW4ndCBhY2Nlc3Mgc2RtYSBxdWV1ZSBhY3Rpdml0eSBjb3VudGVy
XG4iKTsKPiAtCQlyZXR1cm4gLUVGQVVMVDsKPiAtCX0KPiArCXNkbWFfdXNhZ2VfY250ciA9ICh1
aW50NjRfdCBfX3VzZXIgKilxX3JwdHIgKyAxOwo+ICAKPiAtCXJldCA9IGdldF91c2VyKHRtcCwg
KHVpbnQ2NF90ICopKHFfcnB0ciArIHNpemVvZih1aW50NjRfdCkpKTsKPiArCXJldCA9IGdldF91
c2VyKHRtcCwgc2RtYV91c2FnZV9jbnRyKTsKCk1heWJlIHlvdSBkb24ndCBuZWVkIHNkbWFfdXNh
Z2VfY250ci4gSnVzdCBpbmxpbmUgdGhlIHBvaW50ZXIKYXJpdGhtZXRpYy4gQW5kIEknbSBub3Qg
c3VyZSB3aHkgeW91IG5lZWQgdG1wIGVpdGhlci4gSXMgaXQgaW4gY2FzZSB0aGUKcmVhZCBnZXRz
IG9ubHkgb25lIGR3b3JkIGFuZCBmYWlscyBvbiB0aGUgc2Vjb25kIG9uZT8gVGhlIGNhbGxlcnMg
d2lsbAppZ25vcmUgdGhlIHZhbHVlLCBpZiB5b3UgcmV0dXJuIGFuIGVycm9yLCBzbyBJIGRvbid0
IHRoaW5rIGl0IG1hdHRlcnMuClNvIHRoaXMgd2hvbGUgZnVuY3Rpb24gd291bGQgYmVjb21lIHZl
cnkgc2ltcGxlOgoKCXJldHVybiBnZXRfdXNlcigqdmFsLCAodWludDY0X3QgX191c2VyICopcV9y
cHRyICsgMSk7CgpOb3cgaXQgY291bGQgcHJvYmFibHkgYmUgYSBzdGF0aWMgaW5saW5lIGZ1bmN0
aW9uIGluIGEKa2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmguCgpJZiB0aGF0IGlzIHRoZSBvbmx5
IHVzZSBvZiBxX3JwdHIgaW4gdGhlIGZ1bmN0aW9uLCB3aHkgbm90IG1ha2UgdGhlCnBhcmFtZXRl
ciB0eXBlIHVpbnQ2NF90IF9fdXNlciAqLCBzbyB5b3UgZG9uJ3QgZXZlbiBuZWVkIHRoZSB0eXBl
IGNhc3QKaW4gaGVyZT8gWW91IGNhbiBhbHNvIGNoYW5nZSB0aGUgdHlwZSBpbiBzdHJ1Y3QgdGVt
cF9zZG1hX3F1ZXVlX2xpc3QgdG8KbWF0Y2guCgpXaGlsZSB5b3UncmUgYXQgaXQsIHlvdSBjb3Vs
ZCBhbHNvIGNoYW5nZSB0aGUgdHlwZXMgb2YgcmVhZF9wdHIgYW5kCndyaXRlX3B0ciBpbiBzdHJ1
Y3QgcXVldWVfcHJvcGVydGllcywgYmVjYXVzZSB1aW50MzJfdCAqIGlzIHJlYWxseSBub3QKdGhl
IGNvcnJlY3QgdHlwZS4gSXQncyBhIHBvaW50ZXIgdG8gdGhlIHdyb25nIHNpemUgYW5kIHRoZSB3
cm9uZyBhZGRyZXNzCnNwYWNlLiBUaG91Z2ggdGhhdCBjaGFuZ2UgbWF5IGhhdmUgYSBmZXcgbW9y
ZSByaXBwbGUgZWZmZWN0cy4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPiAgCWlmICghcmV0KSB7Cj4g
IAkJKnZhbCA9IHRtcDsKPiAgCX0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
