Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B9EC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 22:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68AC2072A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 22:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68AC2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D60B6EB3C;
	Fri, 15 Nov 2019 22:37:20 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820050.outbound.protection.outlook.com [40.107.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14BB6EB3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 22:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9OGX2z8+peHG+ghCKjM0a2hy9uY5b6g/mlhfpSVM1DzzoWOeEk8RWW3rgw3SqdOV6VMOVyoK31+cn466/VLxmeIswmjKdSw6O+g6cjO/y7msQMDg1sdVU/Zx7FJ9lw/FdC3KTe1OQkzTbt9/69cE01XE4p2jNOy3esG/3oPfKfAG/5k4gC+Nm0I9rQHtXPZLLfxQovQU1rl5oNzI+3IZq7XTabY19vmqjekgQVYHx62VjV0CtzQwItoY5RjwsKwNQJnK6BOU4y9JGgFAAs65ZzkkJG7a0jZKFJ6mhWGQEhA16rY+UqVSuiiKBJYarHIm7vbNTPJju0Vcch9Z/CpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3VeMMy7c8vuvZburnUgnWj8vyzXOUwOk0dH6rURhrM=;
 b=iOfkjgq5Ke1WJBZEO1Z1zF8aroQUOLSSE0BNYeN36cCwB5z2ZZLw9P5CSf824mNDTZcOawJhrAwHTDzCxilgx9uQM81vmMAtXp6Rvi4z3YG37I7EC5m5evX8/AWWzMLr9nxb7nFCqKsFJ1gWtqI56csUkaNPhqoDM01Omk4sTx0PzzVmoHPXevX3OZPZewJQPT8b5FDeHiziWFDQT2xuKg7AjodPbTToQo4Np+Ni384GAJD1OKaXXfUEG/NHmZZ6NZd5uvjkgxRpAdKCz5yVHGw8wk3uXSBuA8Qmt8xhbeL9asOOLwhdYjxU3kcZ1mt8KSGNKV3TYuY32OJNtPigLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1254.namprd12.prod.outlook.com (10.168.169.17) by
 CY4PR12MB1398.namprd12.prod.outlook.com (10.168.168.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Fri, 15 Nov 2019 22:37:16 +0000
Received: from CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::bdea:c9ab:7613:bb00]) by CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::bdea:c9ab:7613:bb00%10]) with mapi id 15.20.2451.027; Fri, 15 Nov
 2019 22:37:16 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn2.5: fix the enc loop with hw fini
To: amd-gfx@lists.freedesktop.org
References: <20191115221508.4900-1-leo.liu@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <f8f27210-39cd-8f8f-bf35-223e4b13e3aa@amd.com>
Date: Fri, 15 Nov 2019 17:37:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20191115221508.4900-1-leo.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::45) To CY4PR12MB1254.namprd12.prod.outlook.com
 (2603:10b6:903:41::17)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7615579-21f9-4b7c-6f23-08d76a1c5db3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1398:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13981C86A15E108FD8DFF33CE4700@CY4PR12MB1398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(26005)(6506007)(47776003)(5660300002)(4001150100001)(386003)(58126008)(316002)(31686004)(305945005)(7736002)(53546011)(2361001)(6246003)(66946007)(76176011)(66556008)(66476007)(6512007)(2486003)(229853002)(2351001)(25786009)(31696002)(23676004)(52116002)(6916009)(36916002)(2906002)(476003)(36756003)(3846002)(6436002)(8936002)(81156014)(8676002)(81166006)(50466002)(446003)(230700001)(2616005)(478600001)(11346002)(99286004)(486006)(66066001)(14454004)(65806001)(65956001)(186003)(6486002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1398;
 H:CY4PR12MB1254.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELjn9nb8V4HG7szernBBOkF7EV8Z6x896/ZswjIY7xTndzUOW13f0+e4uMdNAmkjGkpQCM4MPgyUPcErZv/OWk5RkTx63gznnGlZIM8Mk+IRNvCSRPcQM39iehyFWJ8izlpiqalbxRy7XC+D8GBzGJ3bOiODj7nIFI2+33A3Y9vF+PNGgiiXaYj9WFUbv7FDjipkewNgrPfViLDae+jfYKAIPU8hDtjqJI1rJ5Z0pniP+iVQGaVPsVjlY5HzK5CXdvddEWeLAHHiTr5kVKzNWufi1iqlgUbBjg/4FxBcE8J3ZnlbKVFhna7WbmL/72yTVwGHsPZKOqxv9Oewwyb8jnSoghZ0QfXi499dQKSV4IJkDribxpv6mJgN1OUvEyxz+73qJvUNiiHEOt0f67AlqeSkQmapjtiwD7u5YAwQFueWA9Yh4qsLQBJ1Ufq9tWdC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7615579-21f9-4b7c-6f23-08d76a1c5db3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 22:37:16.2042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5RWp1OmNs86BxnAuT0trLe6/wXN1+bNnrfeK7XeLJMRdvrGSlzvhlsaxBu5tife
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1398
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3VeMMy7c8vuvZburnUgnWj8vyzXOUwOk0dH6rURhrM=;
 b=GlP5FETBqeGOAdAI+PbG9vivel4gTkvIfeQlJQOIKwQOpV0cHBol/P3rQK7CAi1dhAhVClbuKOwsQuAa82rIiRQuEI6thCqtcwRMsmVL5AZTC++mOEufKqFPZYGsuiCRj4BXdxb0PbliqXkX1cqXF+xmOqG0jGDlH4uxFHGXcwM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
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
Message-ID: <20191115223714.LKoZVogHg1QVwY41KoE5i2UdoNiBrtA8myjcibhN80c@z>

UmV2aWV3ZWQtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+CgpPbiAyMDE5LTExLTE1
IDU6MTUgcC5tLiwgTGVvIExpdSB3cm90ZToKPiBGaXhlczogOTA3MmM1ODQgKGRybS9hbWRncHU6
IG1vdmUgSlBFRzIuNSBvdXQgZnJvbSBWQ04yLjUpCj4KPiBTaWduZWQtb2ZmLWJ5OiBMZW8gTGl1
IDxsZW8ubGl1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y25fdjJfNS5jIHwgNiArKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YyXzUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKPiBp
bmRleCA0NTFkYzgxNGQ4NDUuLjQyZDZiOWYwNTUzYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmNuX3YyXzUuYwo+IEBAIC0yNjgsNyArMjY4LDcgQEAgc3RhdGljIGludCB2Y25fdjJf
NV9od19maW5pKHZvaWQgKmhhbmRsZSkKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKPiAgIAlzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmc7Cj4gLQlpbnQgaTsKPiArCWludCBpLCBqOwo+ICAgCj4gICAJZm9yIChpID0g
MDsgaSA8IGFkZXYtPnZjbi5udW1fdmNuX2luc3Q7ICsraSkgewo+ICAgCQlpZiAoYWRldi0+dmNu
LmhhcnZlc3RfY29uZmlnICYgKDEgPDwgaSkpCj4gQEAgLTI4MCw4ICsyODAsOCBAQCBzdGF0aWMg
aW50IHZjbl92Ml81X2h3X2Zpbmkodm9pZCAqaGFuZGxlKQo+ICAgCj4gICAJCXJpbmctPnNjaGVk
LnJlYWR5ID0gZmFsc2U7Cj4gICAKPiAtCQlmb3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51bV9l
bmNfcmluZ3M7ICsraSkgewo+IC0JCQlyaW5nID0gJmFkZXYtPnZjbi5pbnN0W2ldLnJpbmdfZW5j
W2ldOwo+ICsJCWZvciAoaiA9IDA7IGogPCBhZGV2LT52Y24ubnVtX2VuY19yaW5nczsgKytqKSB7
Cj4gKwkJCXJpbmcgPSAmYWRldi0+dmNuLmluc3RbaV0ucmluZ19lbmNbal07Cj4gICAJCQlyaW5n
LT5zY2hlZC5yZWFkeSA9IGZhbHNlOwo+ICAgCQl9Cj4gICAJfQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
