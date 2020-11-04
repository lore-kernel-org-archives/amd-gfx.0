Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7DFC2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 11:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D722236F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 11:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T9AOhjuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D722236F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791EE6ECE3;
	Wed,  4 Nov 2020 11:55:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C266ECE3
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 11:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6nORY93GNpEjR5nHKSICjCY9ztAhxIj7metXVntq/7cFsKROziVRSmwZxMzJryVG+hIj7KQbZ6CtnBFi14gCIuTXjVqOVzhFq3oVbEbQPoEAAXry44iUAs4xZq+mD1tPehktgiMEtMPGVS+C+EUU9RKN0+cIE4aNHN+ODYuWWWCEONUD3oow/5aKljR6zZA3wXajnQ0E9lnLynCp/tC3z2FaEkC00VcgUNGvt6MnywHaD/ECxueTxWU8P26WJssjxejIY7TTRR3Og5K3/DmJH0R+rssLfzVvIzoSSPsygWXhNbTI8p3y6zHw3Ctp82HBBuAKRt8GkS23YGji7hEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzv9Y4XjAl/J7iJ/8OWuTqb610ErS1z8b6km6OSkz9U=;
 b=IGI2tMCBH1ULxDgjE1MrGEXMIX9fkbary/IM7mWxLf3W4xfiW+8HpTvVyo11wBZZkGpOvuS3B1q56RpkrJNn2q8Vo0Gn9HWKew2ayUWulFaLi0Rx+ACV7rPm5oX2B+SVW7jLLdmJ+H6iCtn0AXgcezSVxwW6ynv8ogvKo4GAQp7pMgK/CO4U2ToY8D019H+7CMCCOS8yFrm0Lbq5CtDHgVYChNB046ds3cNsp3JGMnbdpki119iw3gkAKB1YNuJo4p3GccnD84Q+Zo1Lq3OEPuzbGm4P9EBkHMAHQlrd7bhEPK6QOFZDaxzE11hq2HFXtu6U6knsjF8ktJhPRw5k4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzv9Y4XjAl/J7iJ/8OWuTqb610ErS1z8b6km6OSkz9U=;
 b=T9AOhjuVedU5CCw2EZ28JAAyQVUXbZYhyVz5vTGya0fz2sWrm6KaBAfpW8QWy8d/CryaBNzg8Jd2CbNyDAV6VOy/fcLQaF1CnU1sfuKBq//1LrXKtu6cXQ4cItGMnG7kDQuh/ZQeuWAei1L5z0HjqGPq88ms9Sk5WyMcfYsKB9E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2417.namprd12.prod.outlook.com (2603:10b6:207:45::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 11:55:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 11:55:02 +0000
Subject: Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201103171340.2978395-1-shashank.sharma@amd.com>
 <7f9cc1a0-ad6b-ee9b-ac7b-4a49d08de1f9@amd.com>
 <MN2PR12MB3133BFD54B552B19A512B27CF2EF0@MN2PR12MB3133.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <211bb89a-4433-3fb8-7849-6323cafe20fb@amd.com>
Date: Wed, 4 Nov 2020 12:54:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MN2PR12MB3133BFD54B552B19A512B27CF2EF0@MN2PR12MB3133.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:208:1::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR04CA0050.eurprd04.prod.outlook.com (2603:10a6:208:1::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.22 via Frontend Transport; Wed, 4 Nov 2020 11:55:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01d27b53-f1b7-40b6-066d-08d880b8763c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2417D11E4BB1D892B73A855983EF0@BL0PR12MB2417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RI//Zqdn/047nP50EJzI2r6LIUysYTaQpJv4roTXRxYgtRYe7xmtx8j1gkwMsherr0aNmkQy0RQBO+3K8JiQnmhD/fx9DBFoVd/qiJEQm5zsXAID2K1x4czA3CFxSkJghLbSNFwZ4mJiO7bhm55kfqmkyBwqxXu0kZLjsiLBVVyVZ30NGxrCp5JDda/V1MWwRMw63gmvxV13xHsI94hU7hJZ7jvWYatC8oCCgMioA2TV/1WSMSIxPMZ/j5DAjoN4Sp98T06RpBT+9HSUQjR4v0KmfOdDX87ioGTAM7wPPa1aYvsqtm7VEzCKoD+fc+CTGPa2hPON7R63EzSkLqDKAQ1NxzBQ9SgU8/KmnipYlz4jJwbrA1QutveS3lHaI8+SsAK43PHx7hMQXrZAfXg9bjeiPxvubmbWcDaxv58it9U5rAjQz8jOEjkmqPqFWkhwTsbftI/c8xgwk/UJzXQ/rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(478600001)(186003)(66556008)(66476007)(66946007)(36756003)(53546011)(6666004)(83380400001)(6486002)(16526019)(31696002)(5660300002)(966005)(2616005)(8676002)(52116002)(86362001)(54906003)(316002)(31686004)(2906002)(4326008)(66574015)(8936002)(110136005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OsjEk7rfAgxg2v0uuKvGdr559RLTz0UWWxNAymgzwMSy/o90Mvc78ylv/THNzrGjJmLkskOCk7+btQ/AWCi4dkxDuK/q49plZxF4XFGpVh4Qm0HeQO144hJTzM5qQgIAE/GbWn0+/To2XqAvqMMqSxaeBmh1U7XSjm/nFFSzXE/3YGuugnfRCTXbEI2mhqOdLIpaHpWAl4E8l8SEWbWBvBwrGG3B/ifzGkb39FOwVWsZiatELYGEhRDCtMX0GEtLh5JDDAGL1Bihn3iCZIxacrh9+wpGYQ3fPDGiPPj/GaILQJEodUHD/NLkNPJ/heYraQmAoyi6FgG9GCsM9nQHqM9PUg0RKEBhhxPHmQHvYrbBsylKlVEfQpe/AD4VPcIx+ehczKtJDQEf9+xYK0enEBeZ/7CNwIFPGvxXFoqJEwPP91iua5qa0xmbRyjARJjMRLEdRR4MKqoydB46JHaAFHCjnK0j5E8MqzDrtQ2e1Jsj/39474m9cyYWfnYk93dpiuoKbafrgBXeVCOBAQeELqiSCxJ2Mgx4th9UaoTE+Mrl5/Um7YkjVT43U5IEY7/zU0lvkHbu1se2mFqbBTQsLfcRvsDEOtkc51UIjHTPaN4MwBBslDiy6NxRl1F0kx0WIzk46RMj0nmQ828wbRAdyztnvjKJvF5MRH5HH6ZHf1Juq+Z94GxKdku+Z8pSCnMvwjPBp8ojBzGq7NX776AahA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d27b53-f1b7-40b6-066d-08d880b8763c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 11:55:02.5954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO6V9szX/k1TIeRA7ZBFcYTeLPcpXBHbUp8wW/P7CrEKAw19OH0hvyG9+y8Y/Dw8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2417
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Qin,
 Eddy" <Eddy.Qin@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDQuMTEuMjAgdW0gMTE6NDAgc2NocmllYiBTaGFybWEsIFNoYXNoYW5rOgo+IFtBTUQgUHVi
bGljIFVzZV0KPgo+IEhlbGxvIENocmlzdGlhbiwKPiBZZXMsIHRoYXQgMTAwIGlzIGhhcmRjb2Rl
ZCBpbiBSYWRlb24sIGFuZCBnaXQgYmxhbWUgc2F5cyBpdCB3YXMgb25lIG9mIHlvdXIgcGF0Y2hl
cyB3aGljaCBtYWRlIGl0IDEwMCBmcm9tIDEyOCDwn5iKLgo+IFdvdWxkIHlvdSBtaW5kIGhhdmlu
ZyBhIGxvb2sgYXQgY29tbWl0IGlkOiA0YjIxY2UxYjRiNWQyNjJlN2Q0NjU2YjhlY2VjYzg5MWZj
M2NiODA2ID8KCkFoLCB5ZXMgdGhhdCBvbmUgOikKClllYWggdGhlIGJhY2tncm91bmQgaXMgdGhh
dCB0aGlzIHdhcyBqdXN0IGFuIGVkdWNhdGVkIGd1ZXNzIGJlY2F1c2UgSSAKY291bGRuJ3QgZmlu
ZCBhbnlib2R5IHdoaWNoIGNvdWxkIHRlbGwgbWUgd2hhdCB0aGUgcmVhbCBsaW1pdHMgb2YgdGhl
IApQTEwgaXMuCgpMb29rcyBsaWtlIHdlIGp1c3QgZm9yZ290IHRvIGFwcGx5IHRoYXQgcGF0Y2gg
dG8gYW1kZ3B1LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IFJlZ2FyZHMKPiBTaGFzaGFuawo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDQsIDIw
MjAgMzozNSBQTQo+IFRvOiBTaGFybWEsIFNoYXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFFpbiwgRWRkeSA8RWRkeS5RaW5AYW1kLmNv
bT4KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBjbGlwIHRoZSByZWYgZGl2aWRl
ciBtYXggdmFsdWUgYXQgMTAwCj4KPiBBbSAwMy4xMS4yMCB1bSAxODoxMyBzY2hyaWViIFNoYXNo
YW5rIFNoYXJtYToKPj4gVGhpcyBwYXRjaCBsaW1pdHMgdGhlIHJlZl9kaXZfbWF4IHZhbHVlIHRv
IDEwMCwgZHVyaW5nIHRoZSBjYWxjdWxhdGlvbgo+PiBvZiBQTEwgZmVlZGJhY2sgcmVmZXJlbmNl
IGRpdmlkZXIuIFdpdGggY3VycmVudCB2YWx1ZSAoMTI4KSwgdGhlCj4+IHByb2R1Y2VkIGZiX3Jl
Zl9kaXYgdmFsdWUgZ2VuZXJhdGVzIHVuc3RhYmxlIG91dHB1dCBhdCBwYXJ0aWN1bGFyCj4+IGZy
ZXF1ZW5jaWVzLiBSYWRlb24gZHJpdmVyIGxpbWl0cyB0aGlzIHZhbHVlIGF0IDEwMC4KPiBNaG0s
IGlzIHRoYXQgMTAwIGhhcmQgY29kZWQgaW4gcmFkZW9uPyBJIGhhdmUgbm8gaWRlYSB3aGVyZSB0
aGF0IGlzIGNvbWluZyBmcm9tLgo+Cj4gQmVzdCB3b3VsZCBwcm9iYWJseSB0byBncmFiIGEgaGFy
ZHdhcmUgZW5naW5lZXIgYW5kIHRyeSB0byBmaWd1cmUgb3V0IHdoYXQgdGhlIHJlYWwgbWF4aW11
bXMgZm9yIHRoZSBQTEwgaXMgdG8gc3RpbGwgcHJvZHVjZSBhIHN0YWJsZSBzaWduYWwuCj4KPiBD
aHJpc3RpYW4uCj4KPj4gT24gT2xhbmQsIHdoZW4gd2UgdHJ5IHRvIHNldHVwIG1vZGUgMjA0OHgx
MjgwQDYwIChhIGJpdCB3ZWlyZCwgSQo+PiBrbm93KSwgaXQgZGVtYW5kcyBhIGNsb2NrIG9mIDIy
MTI3MCBLaHouIEl0J3MgYmVlbiBvYnNlcnZlZCB0aGF0IHRoZQo+PiBQTEwgY2FsY3VsYXRpb25z
IHVzaW5nIHZhbHVlcyAxMjggYW5kIDEwMCBhcmUgdmFzdGx5IGRpZmZlcmVudCwgYW5kCj4+IGxv
b2sgbGlrZSB0aGlzOgo+Pgo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKwo+PiB8UGFyYW1ldGVyICAgIHxBTURHUFUgICAgICAgIHxSYWRlb24gICAgICAgfAo+
PiB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAo+PiArLS0tLS0t
LS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+PiB8Q2xvY2sgZmVlZGJhY2sg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAo+PiB8ZGl2aWRlciBtYXggIHwgIDEyOCAgICAg
ICAgIHwgICAxMDAgICAgICAgfAo+PiB8Y2FwIHZhbHVlICAgIHwgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgfAo+PiB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
fAo+PiB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAo+PiArLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+PiB8cmVmX2Rpdl9tYXgg
IHwgICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAo+PiB8ICAgICAgICAgICAgIHwgIDQyICAg
ICAgICAgIHwgIDIwICAgICAgICAgfAo+PiB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgfAo+PiB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgfAo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+PiB8
cmVmX2RpdiAgICAgIHwgIDQyICAgICAgICAgIHwgIDIwICAgICAgICAgfAo+PiB8ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAo+PiArLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+PiB8ZmJfZGl2ICAgICAgIHwgIDEwMzI2ICAgICAg
IHwgIDgxOTUgICAgICAgfAo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKwo+PiB8ZmJfZGl2ICAgICAgIHwgIDEwMjQgICAgICAgIHwgIDE2MyAgICAgICAgfAo+
PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+PiB8ZmJfZGV2
X3AgICAgIHwgIDQgICAgICAgICAgIHwgIDkgICAgICAgICAgfAo+PiB8ZnJhYyBmYl9kZV5fcHwg
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tKwo+Pgo+PiBXaXRoIHJlZl9kaXZfbWF4IHZhbHVlIGNsaXBwZWQg
YXQgMTAwLCBBTURHUFUgZHJpdmVyIGNhbiBhbHNvIGRyaXZlCj4+IHZpZGVtb2RlIDIwNDh4MTI4
MEA2MCAoMjIxTWh6KSBhbmQgcHJvZHVjZSBwcm9wZXIgb3V0cHV0IHdpdGhvdXQgYW55Cj4+IGJs
YW5raW5nIGFuZCBkaXN0b3J0aW9uIG9uIHRoZSBzY3JlZW4uCj4+Cj4+IFBTOiBUaGlzIHZhbHVl
IHdhcyBjaGFuZ2VkIGZyb20gMTI4IHRvIDEwMCBpbiBSYWRlb24gZHJpdmVyIGFsc28sIGhlcmU6
Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9mcmVlZGVza3RvcC9kcm0tdGlwL2NvbW1pdC80YjIxY2Ux
YjRiNWQyNjJlN2Q0NjU2YjgKPj4gZWNlY2M4OTFmYzNjYjgwNgo+Pgo+PiBDYzogQWxleCBEZXVj
aGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPgo+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiBDYzogRWRkeSBRaW4gPEVkZHkuUWluQGFtZC5j
b20+Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1h
QGFtZC5jb20+Cj4+IC0tLQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cGxsLmMgfCAyICstCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BsbC5jCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BsbC5jCj4+
IGluZGV4IDFmMjMwNWI3YmQxMy4uMjNhMmUxZWJmNzhhIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BsbC5jCj4+IEBAIC04NSw3ICs4NSw3IEBAIHN0YXRpYyB2b2lk
IGFtZGdwdV9wbGxfZ2V0X2ZiX3JlZl9kaXYodW5zaWduZWQgbm9tLCB1bnNpZ25lZCBkZW4sIHVu
c2lnbmVkIHBvc3RfCj4+ICAgIAkJCQkgICAgICB1bnNpZ25lZCAqZmJfZGl2LCB1bnNpZ25lZCAq
cmVmX2RpdikKPj4gICAgewo+PiAgICAJLyogbGltaXQgcmVmZXJlbmNlICogcG9zdCBkaXZpZGVy
IHRvIGEgbWF4aW11bSAqLwo+PiAtCXJlZl9kaXZfbWF4ID0gbWluKDEyOCAvIHBvc3RfZGl2LCBy
ZWZfZGl2X21heCk7Cj4+ICsJcmVmX2Rpdl9tYXggPSBtaW4oMTAwIC8gcG9zdF9kaXYsIHJlZl9k
aXZfbWF4KTsKPj4gICAgCj4+ICAgIAkvKiBnZXQgbWF0Y2hpbmcgcmVmZXJlbmNlIGFuZCBmZWVk
YmFjayBkaXZpZGVyICovCj4+ICAgIAkqcmVmX2RpdiA9IG1pbihtYXgoRElWX1JPVU5EX0NMT1NF
U1QoZGVuLCBwb3N0X2RpdiksIDF1KSwKPj4gcmVmX2Rpdl9tYXgpOwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
