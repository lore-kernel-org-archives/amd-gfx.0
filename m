Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC3CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 21:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D658F2072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 21:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S8urY386"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D658F2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7496F6E03A;
	Mon, 17 Aug 2020 21:45:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F436E03A
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 21:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtAml4Yo1kNnMDKHuYOYgCRZ1/NNkHs+eJRwmYUhtvguOPRTfZGd6nM72CzAVr2L4z3ni5VX3xcRuZSjkEvEsWSy3Y7CddpY71pTIkAcvHb9SZ2VNx6GC29qqFViNRBE2VZ3LAvocg7o4geLsnvMRxfFNALPegVGbnmD+or/v+cTNbCOgEIz2APBFvhRotWi662iN0kCTkfAWsKoAYEmgKR4LLgnkgH1PUTroTG1qFlemM0oyCHDmFm52sHm1GZEX6I8v+Y2Q6thR0GY+zzGsMNpvuVqhOlfu1Ha/5HNgsoZvU3Ov1r1CmffaDW0tUZupPlyRLD/Im7bg73pi5NtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnd/W5rlBPyCXL2FY36WF1Acgi/A/brYkMq4OMjtnGM=;
 b=C/efCWU5862UEXiwaAZuNhmb2gDs9IHAHio6sutQxvIvpVA6SGs0bA/KbPd03qGf0UgeG71UJHYt0dJ12gcLK1PxJqRUiUMUKvqBvxuOO4YtmbAoxadIjZ1Kl2IXHrFjWsFbNevu5BuYcoGPAyWRPuF5g4XL8qY3W2ozHtmIOslWaH0/wGETaXmpfq0b/mEso4eQ0j/jq46IigYUZ9i4jLECsNhBvdmqQFal8CsJ+nDeT+RhdOoWMyE/NZaHVyo4nZz/LamVxG4bIgG9rBzixY3agmj+tlajJy9c6qGoMNbEiJktw6QdA4FkWfNiUEV+mX+ioHgCKDnG0mwd8/YRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnd/W5rlBPyCXL2FY36WF1Acgi/A/brYkMq4OMjtnGM=;
 b=S8urY3868A9tjzsjJo7ujxVr5xY/7aTL/0hA9fsFeTeLSnNaET2PM+ppAvb2gYA5HcWZ1OOqVFqy27pkJmFS4U+zBOtpNLe2h/rofnWFz8Pqja5yUr3gwBrVKojDkAxHuncCXSdn37te+zTPmQXi6RgjQxT6ltkSgk1sKe2OXlc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 21:45:03 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 21:45:03 +0000
Subject: Re: [PATCH] drm/amdkfd: sparse: Fix warning in reading SDMA counters
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200817204518.2827-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <26b867c2-e877-8aa6-0488-f13aee2c405e@amd.com>
Date: Mon, 17 Aug 2020 17:45:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817204518.2827-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::24) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0145.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 21:45:03 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: afbfa27c-61d3-4b83-7c25-08d842f6cc85
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24471E31993CB0C138E4B419925F0@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBcltS3Ji8mkMgFwu+je9+7Uo7IaFVk6ZXNCXu9xQsMcjWc+7qYyrQGJLQXfKUDQUhuXseVdqQpWOW3c0U2syEsb3kSk7IGSpeyxuDuQYUM18yGkZH3f9E+IEaY9xGLSDGRuKPY0I0h7m7YO/353yf35ZE0sQWCZylAIvGigkVG6jyjwfn9P1EKkKbhyGmxy14Ppns8bBdyv8mKg5eC826EZDQsxScwbj9wMBhvuyRHf1PLeRtyKCRGF0kOGri4LGo/yjafLja3huoE+B19DNgpnu/sAPsjHy0iU2keqPpPfwYkJlWynPIolCUR7oh99GhkkdUZvJY3IlvevmqO+6DcJw6OtNgz/R92FRdIKeK0vcP7bZB5pPVsN3wk1WY4d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(52116002)(36756003)(44832011)(956004)(2616005)(31686004)(86362001)(6486002)(478600001)(66476007)(83380400001)(31696002)(16576012)(2906002)(26005)(66946007)(66556008)(5660300002)(316002)(8676002)(186003)(16526019)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VNijfp4OzCmmAqU6pwPdp+V19GBrjBRCRfAsd6WsYyWrl3AGB2sLTDZooveRk4CO3BatpRvbLkD0jEX2WrPzTmacJZ4cxU8bc9YvPgkyExf8AVU/v+Z1lSjIqB8mHcI8ftTdMXxBWX8qIxTCKhy28fBv0aCNaee+HfzO93j513RBNSNIhSoL1bMllfWo675PUOz2Do6rAkz1lbBTXtrzX50AInj9SCAKo/MTR9yrgSobOp0a91OtVIWK0XrKH0bKTdah6i2RbqFJjlIs9JHYd0tSV8MiDi7sBh+Vga2oW0FzWFkgjy1t47yAtLlQBJrZiNycDcI8YukLylLx1BsWLpdfaH0ca8JoNQwPmH8aWHrnQ/m3PSfTkGY4uOcxv9j8Fu5NN/pTFcC0v5W1Bktdy5gHdvT/qRYlG3diWTyWSqobJFSmTZIZjojMyprQBc3uKVO1/UHfgNdcIJpc2M2Wv5h9DQn9P+c3cnCxG+HjAEG4Xz70MOMvNfvxvvXhRFjYpMZRkC+wDL26bDkyuWj1358jV06dqrH/a9lXOsiADo9qPzF+AsQhaUrDSlDHtql1fOyWVG8Qx5l35ktg68akZMisJJVt9u3C4IQ1t/UTFZOTdsp27tCz3gkypEl128YDNi8QaA3YviSTJwMv09b0fQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbfa27c-61d3-4b83-7c25-08d842f6cc85
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 21:45:03.5602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnEcYkaaokQ4eGH8KSvRhZhf+fqWNdK8eu42WuQDvcq2c4BXXAQ48bF+SCf/4oMTjaLsfAMG8tvmdVHzxNFjsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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

CkFtIDIwMjAtMDgtMTcgdW0gNDo0NSBwLm0uIHNjaHJpZWIgTXVrdWwgSm9zaGk6Cj4gQWRkIF9f
dXNlciBhbm5vdGF0aW9uIHRvIGZpeCByZWxhdGVkIHNwYXJzZSB3YXJuaW5nIHdoaWxlIHJlYWRp
bmcKPiBTRE1BIGNvdW50ZXJzIGZyb20gdXNlcmxhbmQuCj4KPiBSZXBvcnRlZC1ieToga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTXVrdWwgSm9zaGkg
PG11a3VsLmpvc2hpQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIHwgOCArKysrKy0tLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMKPiBpbmRleCBl
MGU2MGIwZDA2NjkuLmE2YTRiYmY5OWQ5YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4gQEAgLTE1NywxOSAr
MTU3LDIxIEBAIGludCByZWFkX3NkbWFfcXVldWVfY291bnRlcih1aW50NjRfdCBxX3JwdHIsIHVp
bnQ2NF90ICp2YWwpCj4gIHsKPiAgCWludCByZXQ7Cj4gIAl1aW50NjRfdCB0bXAgPSAwOwo+ICsJ
dWludDY0X3QgX191c2VyICpzZG1hX3JwdHI7CgpUaGlzIG5hbWUgaXMgbWlzbGVhZGluZy4gWW91
IG5ldmVyIHBvaW50IHRoaXMgdG8gdGhlIGFjdHVhbCBycHRyLiBDYWxsCnRoaXMgc2RtYV91c2Fn
ZV9jbnRyIG9yIHNvbWV0aGluZyBzaW1pbGFyLgoKCj4gIAo+ICAJaWYgKCF2YWwpCj4gIAkJcmV0
dXJuIC1FSU5WQUw7Cj4gIAkvKgo+ICAJICogU0RNQSBhY3Rpdml0eSBjb3VudGVyIGlzIHN0b3Jl
ZCBhdCBxdWV1ZSdzIFJQVFIgKyAweDggbG9jYXRpb24uCj4gIAkgKi8KPiAtCWlmICghYWNjZXNz
X29rKChjb25zdCB2b2lkIF9fdXNlciAqKShxX3JwdHIgKwo+IC0JCQkJCXNpemVvZih1aW50NjRf
dCkpLCBzaXplb2YodWludDY0X3QpKSkgewo+ICsJc2RtYV9ycHRyID0gKHVpbnQ2NF90ICopKHFf
cnB0ciArIHNpemVvZih1aW50NjRfdCkpOwoKU2hvdWxkIHRoaXMgY2FzdCB0byAodWludDY0X3Qg
X191c2VyICopPyBBIG1vcmUgZWxlZ2FudCB3YXkgdG8gZ2V0IHRoZQpvZmZzZXQgd291bGQgYmU6
CgrCoMKgwqAgc2RtYV91c2FnZV9jbnRyID0gKHVpbnQ2NF90IF9fdXNlciAqKXFfcnB0ciArIDE7
CgoKPiArCj4gKwlpZiAoIWFjY2Vzc19vaygoY29uc3Qgdm9pZCBfX3VzZXIgKilzZG1hX3JwdHIs
IHNpemVvZih1aW50NjRfdCkpKSB7CgpJcyB0aGUgZXhwbGljaXQgY2FzdCByZWFsbHkgbmVlZGVk
IGhlcmU/IEFuZCBhcyBmYXIgYXMgSSBjYW4gdGVsbApnZXRfdXNlciBhbHJlYWR5IGNoZWNrcyBh
Y2Nlc3Nfb2suIFNvIHRoaXMgY2hlY2sgaXMgcHJvYmFibHkgcmVkdW5kYW50LgoKUmVnYXJkcywK
wqAgRmVsaXgKCgo+ICAJCXByX2VycigiQ2FuJ3QgYWNjZXNzIHNkbWEgcXVldWUgYWN0aXZpdHkg
Y291bnRlclxuIik7Cj4gIAkJcmV0dXJuIC1FRkFVTFQ7Cj4gIAl9Cj4gIAo+IC0JcmV0ID0gZ2V0
X3VzZXIodG1wLCAodWludDY0X3QgKikocV9ycHRyICsgc2l6ZW9mKHVpbnQ2NF90KSkpOwo+ICsJ
cmV0ID0gZ2V0X3VzZXIodG1wLCBzZG1hX3JwdHIpOwo+ICAJaWYgKCFyZXQpIHsKPiAgCQkqdmFs
ID0gdG1wOwo+ICAJfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
