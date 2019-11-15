Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C1C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 22:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36E720733
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 22:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36E720733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50BD6EB37;
	Fri, 15 Nov 2019 22:30:35 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820085.outbound.protection.outlook.com [40.107.82.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F526EB37
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 22:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7HeYfvOyb2OnAFJDCFBzTUSl9CO4IPqqtyqrK3FT2yt92sxSZw2r9LBJwM7U40ftFmBAG/uoIK0poAo7oE3j2HJWCkEHLSgGC11Xv29DcD6TKYrg8+/MG8GcW/N9GfTcHpr8JuZ4L4C1heBHewrrkq1e6lITeZHcaMdOe8vLuExRdy7oOUc206+WqvBTHMATlv6UXKrzMe7vUGbW7216nr4E/teUKwTTdYvM0SwWD63nZUYyEHeubydc6BZzdQUKW5CF2UvyD7RXt/G/FMEXKoQlU3w3to91lxzBCRJNcxILZfsTMDQg/iq2Xpw9iq9AmEQ47+2wbSaOVgsiZJJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amndch6pPOxXxV989GoVwfG1zOpqCzWRaqQ7f8mV8Lo=;
 b=kZ7pTiJhXhSggaGSLjITmjDw1bR2s1Dg8piIf6v6HmlfGLzjJY1GDZuge+rvcjBStHLyXGBqxeubBNw20AO4XrwQhylbYQtLBfpHZAXpoVnkLt+P9eryLW9Vh0M8aT9BZUrkPG/Wx651WHv4c+Rx3vK2ZLAfA44tZfxapSZgwxID01MsbgNKNPpObgmWRtNz8si/U9HteW8GUamJwNlBlQrAJpzGhnhfDpd+0BkiglDPx61hNIyQg5/7Mspxx7DPIGupsA9W1sDXpyNGXeXBsJ6KzbsWwtJnoDW3+utBUf1XhguYBaYjLvFEKsmztQTVulOgGJPjPvPH/bgFrlhbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2457.namprd12.prod.outlook.com (52.132.180.32) by
 MW2PR12MB2474.namprd12.prod.outlook.com (52.132.180.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 22:30:32 +0000
Received: from MW2PR12MB2457.namprd12.prod.outlook.com
 ([fe80::4556:b416:d7e0:d83b]) by MW2PR12MB2457.namprd12.prod.outlook.com
 ([fe80::4556:b416:d7e0:d83b%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 22:30:32 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn2.5: fix the enc loop with hw fini
To: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Zhu, James" <James.zhu@amd.com>
References: <20191115221508.4900-1-leo.liu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <a8b2bc99-fafe-f5ce-1b55-7feaece5e94f@amd.com>
Date: Fri, 15 Nov 2019 17:30:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
In-Reply-To: <20191115221508.4900-1-leo.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To MW2PR12MB2457.namprd12.prod.outlook.com
 (2603:10b6:907:8::32)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ffc547b-7597-4335-3cf1-08d76a1b6cc8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2474:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB247408ADF9E1A240F4AFCC19E5700@MW2PR12MB2474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(229853002)(8936002)(446003)(186003)(3846002)(6436002)(6116002)(5660300002)(26005)(53546011)(14454004)(6486002)(2906002)(76176011)(31696002)(86362001)(36916002)(110136005)(305945005)(66066001)(6636002)(25786009)(6506007)(7736002)(47776003)(65956001)(58126008)(316002)(99286004)(65806001)(478600001)(8676002)(81156014)(81166006)(52116002)(2486003)(23676004)(50466002)(230700001)(31686004)(36756003)(2616005)(476003)(386003)(44832011)(486006)(6246003)(11346002)(66476007)(66946007)(66556008)(4001150100001)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2474;
 H:MW2PR12MB2457.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHI/DH60VKePiiA7ofTZ++jqj89WwS0vbRICAuygSQGkSadavJwtmuoBZKinHhob9jxjjrzdkcqfybkW5zhrecJHSfP+vCPyGXIhloEWso6eOA1a9QKQtiiS1J9jhUhgrK4h5K20il1+m8HAOZEtbZVUq253XO4ulZreQufzn5V2C2vaQj6WSTARho+8XGrSIJmK68TBRFateJezsMUgPoCA9I3NE81eUQq5+Wi81sc2Kz5qE1ndzxaOGfUOyVF6qy+JC9hf/ZEGhqipabCy84jpwJfs2HZDwfa42npN3103sm5+LkfNPLem8cehuNd+hIqatIDpdegSz5TMsKH7qUg9mbztD2QK1fB9sa6wSKg5MmXOrUxTgU5ND+eJrK1seYMHLxN68GYaUOwStam5SvyZfnVOYMK28velVZBYnPF3Qss8NJjyOKkSoNNPp0RF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffc547b-7597-4335-3cf1-08d76a1b6cc8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 22:30:31.9696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVEJi65g3rMSyWZGkDPKcGujVFow9gNzZY6cfSfwyJzUWyfmyK4Ip/v+R54E1ZEv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2474
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amndch6pPOxXxV989GoVwfG1zOpqCzWRaqQ7f8mV8Lo=;
 b=Vw4n5Tfrd9EvocdZwEtopWvxXb64wtyKeMGd+Ld/H4nmTo5Zs9xEscq0B+Wj10gu7wOzxXfkwKci9gCzO1RaVrsOC3kZ5n2hiATKL3KAjwLQYzAOPz8v9l6OymusFjyPVErjUOuFx4NfufL2XsEXJPYBYEHegNLcP3zYF8u1Q/Q=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Message-ID: <20191115223030.SiNag25ZL3yumqgBlcEm46h1sjt1lKK04X1zj6lJ3GA@z>

Ck9uIDIwMTktMTEtMTUgNToxNSBwLm0uLCBMZW8gTGl1IHdyb3RlOgo+IEZpeGVzOiA5MDcyYzU4
NCAoZHJtL2FtZGdwdTogbW92ZSBKUEVHMi41IG91dCBmcm9tIFZDTjIuNSkKCkp1c3QgY2hlY2tl
ZCB0aGUgYnVnIHdhcyBleGlzdGluZyBiZWZvcmUgdGhlIGNoYW5nZXMgYWJvdmUuCgoKUmVnYXJk
cywKCkxlbwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+Cj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jIHwgNiArKystLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKPiBpbmRleCA0NTFkYzgxNGQ4NDUuLjQy
ZDZiOWYwNTUzYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25f
djJfNS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYwo+IEBA
IC0yNjgsNyArMjY4LDcgQEAgc3RhdGljIGludCB2Y25fdjJfNV9od19maW5pKHZvaWQgKmhhbmRs
ZSkKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqKWhhbmRsZTsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7Cj4gLQlpbnQg
aTsKPiArCWludCBpLCBqOwo+ICAgCj4gICAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1f
dmNuX2luc3Q7ICsraSkgewo+ICAgCQlpZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEg
PDwgaSkpCj4gQEAgLTI4MCw4ICsyODAsOCBAQCBzdGF0aWMgaW50IHZjbl92Ml81X2h3X2Zpbmko
dm9pZCAqaGFuZGxlKQo+ICAgCj4gICAJCXJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Cj4gICAK
PiAtCQlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51bV9lbmNfcmluZ3M7ICsraSkgewo+IC0J
CQlyaW5nID0gJmFkZXYtPnZjbi5pbnN0W2ldLnJpbmdfZW5jW2ldOwo+ICsJCWZvciAoaiA9IDA7
IGogPCBhZGV2LT52Y24ubnVtX2VuY19yaW5nczsgKytqKSB7Cj4gKwkJCXJpbmcgPSAmYWRldi0+
dmNuLmluc3RbaV0ucmluZ19lbmNbal07Cj4gICAJCQlyaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNl
Owo+ICAgCQl9Cj4gICAJfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
