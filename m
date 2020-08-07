Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60686C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 15:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301462072D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2oa305Tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301462072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C316E9FA;
	Fri,  7 Aug 2020 15:00:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C066E9FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 15:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT5V1feNj8msDc6M8Rczcm9ki915FJDSllfuWxdac3UkCwoqt4eZgCQlsDOHZD4z6SajuMCmknPzWSwxt7ZNiM1Z/kjy8fLN6yJfBMsug3FfDgfptoMvZ4a13XSA94hBggs2aLAWvXq8yEOncfn55RhAEta+Q3ylt+7OjbfqPFiUs0LZtH1VK3TB3JDhLYGPTJIFylVqgXnK/dPIdgYJUjOyXsFd2+Ze08Nt3HebBm4qY+b7fhyv81NULR/d7vKDEzebHisadR12v6D0BKYZt6SbiHuwzjkYR3/McBP4FGBpY7yrceTHjI7GhDSKuhMWwVfF3m3gGrZ2HzNT+A70hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk8bqdwE/0pbyrT7x+lFEayAayJlxx7hOGyzGG6UAOI=;
 b=e4OK/UopnRyoFDfLJ/j/JHd6WTYPrwZQAXQLF7yRg1oRP7MCDJQx9YaVr2Y4TaDS5GCTcBUzQAoguBnQor5zDMVhy8xAYrohcKY84Wxc3iSPMPgref0vqF4CIjc8JC84wMf1GinsZZSvP0E2q7nXf0gllAa3UYg99GWltBwN4eBDfQQ1dWsPq9e225AFpvLzcJYB1zHLIf0zfWOAJiFQU9ADsPX9/IRIRX0iJCvzmgs0IejX4sBCyfx2qUjlrfx7WWUkrHAmvuP6TkZozKzx79wfkaN+ifjKhyg1rVSR8LCJvTCsLfQEF7r3SUweIhmpy6wGpPe/xFgahvxY4IF7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk8bqdwE/0pbyrT7x+lFEayAayJlxx7hOGyzGG6UAOI=;
 b=2oa305Tz9DrNJi3Jfe8l4P4H/Tl009RHlA78g3+Dz27lzKTJBTBP9SBAWiLtY35n8RBNjzi0gRM/Qu34vNxKcFFTjoiXC8saHoxg7nWMV9I1a9MUg818pqKgFDX5h5ha5oWE4Dg0ivvPJLVlwfiQRR8PsRgN+MZZfRPNIxAa+Pg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 15:00:41 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9%7]) with mapi id 15.20.3239.023; Fri, 7 Aug 2020
 15:00:40 +0000
Subject: Re: [PATCH] drm/amdkfd: force raven as "dgpu" path
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200807082545.2382890-1-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <0ae61c8f-970c-417b-0ae4-639ea1a95f9a@amd.com>
Date: Fri, 7 Aug 2020 11:00:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200807082545.2382890-1-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::33)
 To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YQBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Fri, 7 Aug 2020 15:00:40 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2bf4d214-ebfe-48c9-948a-08d83ae2a6a6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45127A9210B5E7997A84A15F92490@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pkYN2VWPaQnYNHniBZRwWoP3Ljpn8uBu3sklcuGvLDjNZsKQIQFkhglAqyR3A9POO1yIfUxP6MxZ6YtsNREsXIUkAJk5gCBTZVEvtna9VCfUZyxuNOedKvli8UdetciJMKTAu3DFQ93lVcNuglKusWnemeP5UNcgZOeUiW7OM7LQ6LOxD0YyicRen5X3o50AT9xmi5SWLV82UQEUPwGU+YjV4SbMYQGQPEqRyb2cugvqOPyw5qXaYnu4jnFIGyMtYqq5DdFRywugLNQAiMfFmxgIwOS2ygcWH5NtE/M7IqnuJ/sjF/PJPfv3XegGav+gZFg8l3BT6dFFLJf8MbhKgME2oioa2PJbx3OupXY4yZQOrWfS2fdErn2ezDdswZg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(86362001)(8676002)(66556008)(44832011)(478600001)(31696002)(6486002)(956004)(66946007)(26005)(66476007)(2616005)(36756003)(83380400001)(8936002)(5660300002)(16526019)(2906002)(316002)(186003)(52116002)(31686004)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xlvJtfEGuehYvyqTIm3kDe7hZMxPRlFGos/3c9xutkQcBPP0a8Gm/WmfbHG68aN78axHlKsJSZfs2KBQQtlsO7p5J4Eew/Sfant/hLNmQbJ5c5lyUsWEIEwIP9h2eKXhP3iURravaujXOlcjfeG5cjr1zFqbyFfleMzhyQRHuUqqK1YTL+ERdfA5t4AKGv27C0Yhbsc5OTNOa5QVVi8LpM/YVI+Qs7wBEfkBxZALDJXLu0thraaoPiGPIcVDwIrs6+sMRsWBCkJ7fWiay0PxeDChixkyCd4dnAE5vZ+gClucuao0Xl4sgZy6Zlo15uqlwmDqnXi//jaBZh/lHIUguZ53BICLkPiajJh6t4gJDq2pk9/ZaKxPqfxSHMYSxkidIPOC1+JSC+UauaklGYzqPvbjvocykAQx76uT6LD3OLGdzIHLxwVr7KiEzga9r1AkDme8PGql25ife3EWQW/rDDiqAqfILx8R3lskVcq1ywbCPhCbAT5ArOkZvLU0Oc8p43besm/r79CHF68gG4p7LL/jkxdTgq0wWyB3O7PMxAvtc/7lVq/3Yugx711ELz23hNi2IYYFO40pB8TYoJoUo26BDJfeu+kCzpBzUNZyWtAz4xWz4triZu2TkDf37ElmpgxiAdzRQZ89pQttPuabvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf4d214-ebfe-48c9-948a-08d83ae2a6a6
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 15:00:40.8448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJdk2YiCzwdQrl3cbpJ08AFRziL9O97DF/fSPT5+0HVhCjieA/IDV51EFiZtwMHjvrJ6tvtK8/zc54+ttKkJ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
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

QW0gMjAyMC0wOC0wNyB1bSA0OjI1IGEubS4gc2NocmllYiBIdWFuZyBSdWk6Cj4gV2Ugc3RpbGwg
aGF2ZSBhIGZldyBpb21tdSBpc3N1ZXMgd2hpY2ggbmVlZCB0byBhZGRyZXNzLCBzbyBmb3JjZSBy
YXZlbgo+IGFzICJkZ3B1IiBwYXRoIGZvciB0aGUgbW9tZW50Lgo+Cj4gV2lsbCBlbmFibGUgSU9N
TVV2MiBzaW5jZSB0aGUgaXNzdWVzIGFyZSBmaXhlZC4KCkRvIHlvdSBtZWFuICJfd2hlbl8gdGhl
IGlzc3VlcyBhcmUgZml4ZWQiPwoKVGhlIGN1cnJlbnQgaW9tbXV2MiB0cm91YmxlcyBhc2lkZSwg
SSB0aGluayB0aGlzIGNoYW5nZSBicmVha3MgZXhpc3RpbmcKdXNlciBtb2RlLiBUaGUgZXhpc3Rp
bmcgVGh1bmsgaXMgbm90IHByZXBhcmVkIHRvIHNlZSBSYXZlbiBhcyBhIGRHUFUuIFNvCnRoaXMg
aXMgbm90IHNvbWV0aGluZyB3ZSB3YW50IHRvIGRvIGluIGFuIHVwc3RyZWFtIExpbnV4IGtlcm5l
bCBjaGFuZ2UuCgpJIHN1Z2dlc3QgdXNpbmcgdGhlIGlnbm9yZV9jcmF0IG1vZHVsZSBwYXJhbWV0
ZXIgZm9yIHRoZSB3b3JrYXJvdW5kCmluc3RlYWQuIFlvdSBtYXkgbmVlZCB0byBkdXBsaWNhdGUg
dGhlIHJhdmVuX2RldmljZV9pbmZvIGFuZCBwaWNrIHRoZQpyaWdodCBvbmUgZGVwZW5kaW5nIG9u
IHdoZXRoZXIgaXQgaXMgYSBkR1BVIG9yIGFuIEFQVS4gVGhlIG9ubHkKZGlmZmVyZW5jZSB3b3Vs
ZCBiZSB0aGUgbmVlZF9pb21tdV9kZXZpY2Ugb3B0aW9uLiBJZiBpZ25vcmVfY3JhdCBpcyBzZXQs
CnlvdSBjYW4gc3VwcG9ydCBSYXZlbiBhcyBhIGRHUFUgYW5kIHJlcXVpcmUgYSBjb3JyZXNwb25k
aW5nIFRodW5rIGNoYW5nZQp0aGF0IGNvbmRpdGlvbmFsbHkgc3VwcG9ydCBSYXZlbiBhcyBhIGRH
UFUuCgpJIHRoaW5rIHN1Y2ggYSBjaGFuZ2Ugd291bGQgYWxzbyBiZSB0aGUgcmlnaHQgZGlyZWN0
aW9uIGZvciBzdXBwb3J0aW5nClJhdmVuIG1vcmUgdW5pdmVyc2FsbHkgaW4gdGhlIGZ1dHVyZS4g
SXQgY2FuIGJlIGV4dGVuZGVkIHRvCmNvbmRpdGlvbmFsbHkgdHJlYXQgUmF2ZW4gYXMgYSBkR1BV
IGF1dG9tYXRpY2FsbHkgaW4gc29tZSBzaXR1YXRpb25zOgoKICAqIGJyb2tlbiBvciBtaXNzaW5n
IENSQVQgdGFibGUKICAqIElPTU1VdjIgZGlzYWJsZWQKClRob3NlIGFyZSBhbGwgc2l0dWF0aW9u
cyB3aGVyZSB0aGUgY3VycmVudCBkcml2ZXIgaXMgYnJva2VuIGFueXdheSAoYW5kCmFsd2F5cyBo
YXMgYmVlbiksIHNvIGl0IHdvdWxkIG5vdCBiZSBhIGtlcm5lbCBjaGFuZ2UgdGhhdCBicmVha3MK
ZXhpc3RpbmcgdXNlciBtb2RlLgoKSW4gYWRkaXRpb24gdGhlIFRodW5rIGNvdWxkIGJlIGNoYW5n
ZWQgdG8gZG93bmdyYWRlIGEgUmF2ZW4gQVBVIHRvIGRHUFUKKGJ5IHNwbGl0dGluZyB0aGUgQVBV
IG5vZGUgaW50byBhIHNlcGFyYXRlIENQVSBhbmQgZEdQVSBub2RlKSBpZiBvdGhlcgpkR1BVcyBh
cmUgcHJlc2VudCBpbiB0aGUgc3lzdGVtcyB0byBkaXNhYmxlIGFsbCB0aGUgQVBVLXNwZWNpZmlj
IGNvZGUKcGF0aHMgYW5kIGFsbG93IGFsbCB0aGUgR1BVcyB0byB3b3JrIHRvZ2V0aGVyIHNlYW1s
ZXNzbHkgd2l0aCBTVk0uCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4gU2lnbmVkLW9mZi1ieTogSHVh
bmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2NyYXQuYyAgIHwgNiArKysrKysKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2RldmljZS5jIHwgNCArKy0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9jcmF0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5j
Cj4gaW5kZXggNmEyNTBmOGZjZmI4Li42NmQ5ZjcyODBmZTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9jcmF0LmMKPiBAQCAtMjIsNiArMjIsNyBAQAo+ICAKPiAgI2luY2x1ZGUg
PGxpbnV4L3BjaS5oPgo+ICAjaW5jbHVkZSA8bGludXgvYWNwaS5oPgo+ICsjaW5jbHVkZSA8YXNt
L3Byb2Nlc3Nvci5oPgo+ICAjaW5jbHVkZSAia2ZkX2NyYXQuaCIKPiAgI2luY2x1ZGUgImtmZF9w
cml2LmgiCj4gICNpbmNsdWRlICJrZmRfdG9wb2xvZ3kuaCIKPiBAQCAtNzgxLDYgKzc4MiwxMSBA
QCBpbnQga2ZkX2NyZWF0ZV9jcmF0X2ltYWdlX2FjcGkodm9pZCAqKmNyYXRfaW1hZ2UsIHNpemVf
dCAqc2l6ZSkKPiAgCQlyZXR1cm4gLUVOT0RBVEE7Cj4gIAl9Cj4gIAo+ICsJLyogUmF2ZW4gc2Vy
aWVzIHdpbGwgZ28gd2l0aCB0aGUgZmFsbGJhY2sgcGF0aCB0byB1c2UgdmlydHVhbCBDUkFUICov
Cj4gKwlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EICYmCj4g
KwkgICAgYm9vdF9jcHVfZGF0YS54ODYgPT0gMHgxNykKPiArCQlyZXR1cm4gLUVOT0RBVEE7Cj4g
Kwo+ICAJcGNyYXRfaW1hZ2UgPSBrbWVtZHVwKGNyYXRfdGFibGUsIGNyYXRfdGFibGUtPmxlbmd0
aCwgR0ZQX0tFUk5FTCk7Cj4gIAlpZiAoIXBjcmF0X2ltYWdlKQo+ICAJCXJldHVybiAtRU5PTUVN
Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMKPiBpbmRleCBkNWU3OTBm
MDQ2YjQuLjkzMTc5YzkyODM3MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZGV2aWNlLmMKPiBAQCAtMTE2LDYgKzExNiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga2ZkX2Rl
dmljZV9pbmZvIGNhcnJpem9fZGV2aWNlX2luZm8gPSB7Cj4gIAkubnVtX3hnbWlfc2RtYV9lbmdp
bmVzID0gMCwKPiAgCS5udW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSA9IDIsCj4gIH07Cj4gKyNl
bmRpZgo+ICAKPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBrZmRfZGV2aWNlX2luZm8gcmF2ZW5fZGV2
aWNlX2luZm8gPSB7Cj4gIAkuYXNpY19mYW1pbHkgPSBDSElQX1JBVkVOLAo+IEBAIC0xMjgsMTMg
KzEyOSwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGtmZF9kZXZpY2VfaW5mbyByYXZlbl9kZXZp
Y2VfaW5mbyA9IHsKPiAgCS5udW1fb2Zfd2F0Y2hfcG9pbnRzID0gNCwKPiAgCS5tcWRfc2l6ZV9h
bGlnbmVkID0gTVFEX1NJWkVfQUxJR05FRCwKPiAgCS5zdXBwb3J0c19jd3NyID0gdHJ1ZSwKPiAt
CS5uZWVkc19pb21tdV9kZXZpY2UgPSB0cnVlLAo+ICsJLm5lZWRzX2lvbW11X2RldmljZSA9IGZh
bHNlLAo+ICAJLm5lZWRzX3BjaV9hdG9taWNzID0gdHJ1ZSwKPiAgCS5udW1fc2RtYV9lbmdpbmVz
ID0gMSwKPiAgCS5udW1feGdtaV9zZG1hX2VuZ2luZXMgPSAwLAo+ICAJLm51bV9zZG1hX3F1ZXVl
c19wZXJfZW5naW5lID0gMiwKPiAgfTsKPiAtI2VuZGlmCj4gIAo+ICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGtmZF9kZXZpY2VfaW5mbyBoYXdhaWlfZGV2aWNlX2luZm8gPSB7Cj4gIAkuYXNpY19mYW1p
bHkgPSBDSElQX0hBV0FJSSwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
