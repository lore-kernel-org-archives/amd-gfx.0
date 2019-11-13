Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE0CC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5B1206E3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5B1206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B796EE82;
	Wed, 13 Nov 2019 22:19:27 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820041.outbound.protection.outlook.com [40.107.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94C16EE82
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zpt0aDHboLDhlpRhFLMtk+cKeorpyBxPctNcc/1dR1n6Gy5KPvwN+UZldYOTOJT0XSpmgQzxM2/FnQNZxAQzVyS+r83HvSVwxYjlBUDC354IK1emg14fYry7aoE29/EoF77Ln4Ty9OUISwqYBeFt6i10mlUewd0HoMo/R+TKK9wyTv0P+DROhNrFiHtE8kshI97T92cgwQ7VKFBlaVFKMRGsM4WQ2PMEZJQg+rZWFMWfaUvRR82ASaGzpETLxmhd3R9V6V/HDzt7loJFl4nDjFaAPS9XN9CY1aNNMxrwpFQ4aZt3JMIkk1N9Qps5O/AE574PdCVmEZxpPMa+0j2uGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h84AGUZqGnZAdMrA4woomhc2c/0dGGY1kvV/M0XFKUY=;
 b=H3++DyT7WGGN7UL9ODxbSzZ+5Yun+XPfkDWzmTkb5KGUwur1ehgaQxNH8Xg/Oxj5Ya3JTzs2CAMx5FEogqjUrZdfkTqWn5W5uqtOlFGgEc/Tr0TAN0WKq+rwKlIllyPzUYqsb8ab7QYTTBZioKsvLpFtS6oE4KyKKSCRTaiUoItELQoQFmB8oKmg1PJU3b66hm7vj9+g3flGkPqbHQRY/qxXITmv6fztS0znkzYvpiuFaopX/jbvYihz4cLSzPdWGwFfVHaAU4UWZkscCa7sFMd1gBy6NqAj1r14wJSKhW9aZch6tr5ZrnT7Lthv+187GXHuBQLBTheYJRRz92xOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3311.namprd12.prod.outlook.com (20.179.82.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 22:19:22 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 22:19:22 +0000
Subject: Re: [PATCH] drm/amdkfd: Rename kfd_kernel_queue_*.c to
 kfd_packet_manager_*.c
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191113220946.32529-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <5105f095-d0b9-cd87-180b-4a378c775d46@amd.com>
Date: Wed, 13 Nov 2019 17:19:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191113220946.32529-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e426f36-27bc-4a4a-7dbf-08d7688788e5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3311D86840C0CD759CC0A49C92760@MN2PR12MB3311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(31696002)(66556008)(386003)(14454004)(44832011)(66946007)(5660300002)(478600001)(26005)(476003)(305945005)(7736002)(25786009)(31686004)(53546011)(86362001)(2616005)(6246003)(6506007)(4001150100001)(66476007)(2906002)(6436002)(2486003)(76176011)(11346002)(446003)(23676004)(36916002)(36756003)(6486002)(316002)(50466002)(58126008)(99286004)(229853002)(8936002)(186003)(486006)(6512007)(52116002)(81166006)(2870700001)(47776003)(66066001)(65956001)(6116002)(3846002)(65806001)(81156014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3311;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7YYP4KTjizTpPXXEZimqZTt2Ey0yTqRtovMTfoLPO7Q8ZNThlrxkxxEFe0fBI79LTzcNg/FyV4Skd6CzN0vPB2bcbc1fStY2s9APqkkIZycq7OqtPl2H4qqT+Q5eS9fj6AnsLtyyA/7JUMZJPLbU8mvj5BY7kuWS3FkYp6ec6SMeB+KZjBuXBhqObgBCv3T2lYdV0BcxRJG/AnJM5xvXiVbIpSQehzPEr+8v2Ery51IDCWrTc6FLAbH0iFwQbFCIBYzYs0QZxTzU5/JgydySUqLT/PWMAqHobH+CqcXJkPrwhnEw4B4FOSu+RYcZfznlRkP4VXH+LxdZ8AXdgieajMFNE37BOtqV4MGi8KFmCExyytFebmXUY3gdlr+vwwGlJHhxKu5cZjF8bJd0ivj1mpbWQLqKThu9peZZkJpfc3K6yaeaq72kt5h7uGHs2hT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e426f36-27bc-4a4a-7dbf-08d7688788e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 22:19:22.4488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY57fF04FTo1DjOKKFQWbz3chYVxQKlEQE0x2D9mO7NOdGtDYSa2/SD/s0QvnjoLp9jHsvHPdmPfiO7CvXCowg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3311
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h84AGUZqGnZAdMrA4woomhc2c/0dGGY1kvV/M0XFKUY=;
 b=gc6+dQerHx93vdjlxnBVHjvDuSo9qb7/2pPuwCXj0z/LPUZkNmSwee0/Tufb+WfgrD8e9Fsdn18UXP07OX8fmQLXudmC1w+WE9kjt8dmfSAz/eLR6ZAyrwt0bdYamFP+NUGX9D0id8ons5NPCjAFX1J81r7jebCPTfh+X5c82y4=
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
Message-ID: <20191113221920.wVj1ZB69VVEOWPRE23nucpo_n41GRLSTEeaGZwyFGAo@z>

T24gMjAxOS0xMS0xMyA1OjA5IHAubS4sIFlvbmcgWmhhbyB3cm90ZToKPiBBZnRlciB0aGUgcmVj
ZW50IGNsZWFudXAsIHRoZSBmdW5jdGlvbmFsaXRpZXMgcHJvdmlkZWQgYnkgdGhlIHByZXZpb3Vz
Cj4ga2ZkX2tlcm5lbF9xdWV1ZV8qLmMgYXJlIGFjdHVhbGx5IGFsbCBwYWNrZXQgbWFuYWdlciBy
ZWxhdGVkLiBTbyByZW5hbWUKPiB0aGVtIHRvIHJlZmxlY3QgdGhhdC4KPgo+IENoYW5nZS1JZDog
STY1NDRjY2IzOGRhODI3Yzc0NzU0NGMwNzg3YWE5NDlkZjIwZWRiYjAKPiBTaWduZWQtb2ZmLWJ5
OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDQgKystLQo+
ICAgLi4uL2FtZGtmZC97a2ZkX2tlcm5lbF9xdWV1ZV92OS5jID0+IGtmZF9wYWNrZXRfbWFuYWdl
cl9haS5jfSB8IDAKPiAgIC4uLi9hbWRrZmQve2tmZF9rZXJuZWxfcXVldWVfdmkuYyA9PiBrZmRf
cGFja2V0X21hbmFnZXJfdmkuY30gfCAwCj4gICAzIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPiAgIHJlbmFtZSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC97a2ZkX2tlcm5lbF9xdWV1ZV92OS5jID0+IGtmZF9wYWNrZXRfbWFuYWdlcl9haS5jfSAoMTAw
JSkKPiAgIHJlbmFtZSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC97a2ZkX2tlcm5lbF9xdWV1
ZV92aS5jID0+IGtmZF9wYWNrZXRfbWFuYWdlcl92aS5jfSAoMTAwJSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9NYWtlZmlsZSBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL01ha2VmaWxlCj4gaW5kZXggZjkzYTE2MzcyMzI1Li41NWJmZWNmMDQyMzkgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvTWFrZWZpbGUKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9NYWtlZmlsZQo+IEBAIC0zOCw5ICszOCw5IEBAIEFN
REtGRF9GSUxFUwk6PSAkKEFNREtGRF9QQVRIKS9rZmRfbW9kdWxlLm8gXAo+ICAgCQkkKEFNREtG
RF9QQVRIKS9rZmRfbXFkX21hbmFnZXJfdjkubyBcCj4gICAJCSQoQU1ES0ZEX1BBVEgpL2tmZF9t
cWRfbWFuYWdlcl92MTAubyBcCj4gICAJCSQoQU1ES0ZEX1BBVEgpL2tmZF9rZXJuZWxfcXVldWUu
byBcCj4gLQkJJChBTURLRkRfUEFUSCkva2ZkX2tlcm5lbF9xdWV1ZV92aS5vIFwKPiAtCQkkKEFN
REtGRF9QQVRIKS9rZmRfa2VybmVsX3F1ZXVlX3Y5Lm8gXAo+ICAgCQkkKEFNREtGRF9QQVRIKS9r
ZmRfcGFja2V0X21hbmFnZXIubyBcCj4gKwkJJChBTURLRkRfUEFUSCkva2ZkX3BhY2tldF9tYW5h
Z2VyX3ZpLm8gXAo+ICsJCSQoQU1ES0ZEX1BBVEgpL2tmZF9wYWNrZXRfbWFuYWdlcl9haS5vIFwK
ClRoaXMgbmFtaW5nIGNvbnZlbnRpb24gaXMgaW5jb25zaXN0ZW50IHdpdGggdGhlIHJlc3Qgb2Yg
S0ZELiBXZSB1c2UgX3Y5LCAKbm90IF9haS4gQWxzbyB0aGUgZnVuY3Rpb24gcyBpbnNpZGUgdGhp
cyBmaWxlIGFyZSBuYW1lZCBfdjkuIElmIHdlIApkZWNpZGUgdG8gY2hhbmdlIHRoYXQgbmFtaW5n
IGNvbnZlbnRpb24sIGl0IHNob3VsZCBub3QgYmUgYWNjaWRlbnRhbCBhbmQgCnBpZWNlLW1lYWwu
IEl0IHNob3VsZCBiZSBkZWxpYmVyYXRlIGFuZCBjb21wcmVoZW5zaXZlLgoKUmVnYXJkcywKIMKg
IEZlbGl4CgoKPiAgIAkJJChBTURLRkRfUEFUSCkva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5v
IFwKPiAgIAkJJChBTURLRkRfUEFUSCkva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLm8gXAo+ICAg
CQkkKEFNREtGRF9QQVRIKS9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXJfY2lrLm8gXAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlX3Y5LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfYWkuYwo+IHNp
bWlsYXJpdHkgaW5kZXggMTAwJQo+IHJlbmFtZSBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYwo+IHJlbmFtZSB0byBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfYWkuYwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlX3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfdmkuYwo+IHNpbWlsYXJpdHkgaW5kZXggMTAw
JQo+IHJlbmFtZSBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVl
dWVfdmkuYwo+IHJlbmFtZSB0byBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0
X21hbmFnZXJfdmkuYwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
