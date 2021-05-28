Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07087C2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 16:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A691C613E5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 16:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A691C613E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4129D6F5FA;
	Fri, 28 May 2021 16:25:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71CD6F5FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 16:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvBjg50zdpIXIPZ+M9/uUvneW8tvh5Rq4uewOyBH0bwQ6MENrDiolB+jTUqlAw5hLerW4o2+YIPvmDMV8BwnkH75DLx3+aWW34hIjBe0UG5xjb4BV1M2LNIf2+8nWqnrUnmUrW4ndhENAPhsA8X5Ub2DE5RFJXDtBwW/nXZHTTfVrMyNCq8ifgPYYS9gxVNv0DgP5DhHPHy+pMvtYkHskjtSR3ORYa8DjX1mN2+CF5ldoflrDeOUaRBcjUOSpGORvDWxaBdi8gpMTOwIiGcyZsn36iHNI7dZozcBRuP45QhjRZt5A0eSScgYW/4WSuyFZcvhPIOyQ0Ixs0al5s7WCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSDRWEj5hOwKHluP0H6c/7X9AT6RWM1ZuEVdYu5A7To=;
 b=aHEAh0njXAJp6KNpzzkQTAVg0dL7qLHL0rGaItIfAM+ZHcTXJr8zplZ0FrZFffypGWV5Jg1FllEMZW1RhI9e/3SGXPT+zqI/W09w9zlMO/jQ3+BWQLrkQNao73zj/8ikJx4u1Vq2bcAWzyE2mG+2Isih++SBUPoiOeNDsUisG3JLEIq0SPSR2e0jOIMgxVHt4mpfQeTbBWlixBtjmWXZ2w2u0amsvQqUYyXzoJ6nI1udgeP+XoZb6MwDRthONg07ctnyNriQP0dx+07i5G9nI8jnXn68vcxdw85aUcP5KXBqnU3wbbi3tXXXFLk0KZcxLCeCEcz3ShqWihqf1NEoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSDRWEj5hOwKHluP0H6c/7X9AT6RWM1ZuEVdYu5A7To=;
 b=F0QpeQSC0qYUUAkBnuH9HnhwRLMpc1C4YCK2rF/gCxpjicoZp0OInv0J6zCWa1BPxS9ZO/f5tiVz//N+DTJXgQvL2EL5EqwAifEztnWDYsOFe03SB6L1fPCKOlM3JqmqyjsqhC0Ok7owDEtG3vF1SF+D2t9LAJEscTaK+wORuA4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 16:25:14 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 16:25:14 +0000
Subject: Re: [PATCH v3 1/1] drm/amdgpu: flush gart changes after all BO
 recovery
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210528155428.75487-1-nirmoy.das@amd.com>
 <7397fd5e-df68-fcad-0fed-34e9026ee776@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <de2775f8-0b90-c973-ba41-74d6c5d66cd9@amd.com>
Date: Fri, 28 May 2021 18:25:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <7397fd5e-df68-fcad-0fed-34e9026ee776@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.72.6]
X-ClientProxiedBy: AM8P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::13) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM8P251CA0008.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 16:25:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6f6b11-424a-4d41-0bf9-08d921f52c80
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5229067E636BADA8B971F5F78B229@DM4PR12MB5229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yk3YQHHSG+erSu5KlkZ9OzC8StQ15DyOnSixU1E4WUFdzrJolYRjuVIWOdQR21kvj3ts0kpx1uSvbNAgYwQ6jP2or4DecziXu9sQHvN+tmJEQ8HSI0kigMC1BJEj28n8Fa0fbSM2IDG3Uo17byq28blDGNUWYmfJsW7Z+Khikz5T/GFXjlmlHc17wwuH756YKCb2E9zVeN5htW+0EqV8UmyMcZyoB61eSo4zJj5ZjCpmTlmUcIqee+Ru4cdiKFF5DO6uF8mu4UBznPwT6pFfdvcfuhiOx71o8zl81NRaZ84cYD+W9KL033oXILpQSm00QX314SmVYAvF/KipmVONvmBsUMKsOOmJ4o2uan2JEtJIYKMlNmb08yFyd3nlD/Kb806UJv0BicTva+peF1b2fhwZW5Vvp+krNhjKrJBZ9chXghdkHuBj9PRXekZrD8Lhsyzds4LXO2pdoJ3HZHLVpnb8Lb1cQ7diVwUnpH1nDo/SnUkysGT94OhagQe7CDEA8orL8HLbbT/BFBLGwvGX5xxzkDr2GkJuVm106I0gHdN9a6qwCsPPsexlu3TscM2pZc/NxwhTut/LOJZAg1XBMFcR+dTnE30l85Ojw2vm99MjLCcJHqvkzFqoGWYbhm+ga8iWYdT+8Agc52c3sEve3OqU4I34LgbkCvWJjO8dBLZoo300Qc2saOQhyH6P5c04k1qauzGuHcYpN6XA6ZmBG32bdUtlSWSBc/dZ1sVRXJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(16576012)(316002)(8936002)(16526019)(186003)(5660300002)(8676002)(83380400001)(6666004)(66574015)(478600001)(38100700002)(66556008)(36756003)(66946007)(66476007)(38350700002)(6486002)(31686004)(52116002)(53546011)(956004)(31696002)(2616005)(26005)(2906002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGc0V2hmeVA0SEVJMjFUMld3bVo3MlU0RWhWVWk5TitYTWtrWGM0bXAzVG9D?=
 =?utf-8?B?azROMlkvVUwrbzhLczRkWDdnVEhYZWFaMkFQY3pYb25PVlZjVHlwM3hSbjhH?=
 =?utf-8?B?UFRoZk1oZXJBZGVQWk5YcCtNSm81eW5iNDBsUkZnQnFGNTFNRHVSS1FoUng3?=
 =?utf-8?B?Y1hXVE5RbUhvdWdQRFZFaWJNY1NVL1d4eW5uVURBM2ZJWlA1bVF4OEVHNWlw?=
 =?utf-8?B?NlcvRFRhMlE4Y3h0d2NpVWtPam9teEJ3TzA1MFBiUzhrOUx3eXVQUDVOTzhz?=
 =?utf-8?B?OGpaZzR3eHNwUlF1elY2ZjFpRzlRWkhsenBaVmZvL0pudXlhSGZtcFhKYmtp?=
 =?utf-8?B?eHVFbjBTQVJiYW9TVmw5K3FGRTIzUlpDZ0pUTzcxZWpaWjE1djJSRU1Ia3B0?=
 =?utf-8?B?VUpuZXBLb3ZtcWVRdDlUekhncUpOYWVtb2Nyc1huanNCY3lqY1dZUUxTTlBV?=
 =?utf-8?B?RGhYUFRETDEzaWdtaTEwK1VKUU8wenpYMEhVaUgvQ3hISjgxMGNnSnJqLzNa?=
 =?utf-8?B?c3VxK2hYSWZsK1RlOHNNdkgxZlAvalc3bjZ3VkhyTmN3aVZiamdSVVhxb2hh?=
 =?utf-8?B?d2o0ZngwaDNtV1J6dWwvc2NQRjUyTDJ6TG03WldYUm9WaFhNU0RxaW9zZ0Vh?=
 =?utf-8?B?azNENkYyNGdhTzVrZ3JZOUtpZ2ErNzJkdE05NWd5OGNxSzFvb1B6eWN0Z1Bx?=
 =?utf-8?B?Qi9QR0YzM3ZpTUovdldZWWprcFpQNHNqRFovRTg0ZW44ZWJ2Mk83ZVdsN3R1?=
 =?utf-8?B?L0lnVzhHZnlMME5welVUeVBFdERCRE10b3d6aFVYZHkvQmpGVTI3NjJ1akdO?=
 =?utf-8?B?cHFqZTh5MFVsVmprN2xYWGdJMks5bWVOcFZzRUZzdktaNXVaUDB6eVdNTWZG?=
 =?utf-8?B?NkxDNUdUL0hVdi83N0tTa0NDZENtcWh5VFZONThHN3o0dWk3Y2RWZDNjVkxI?=
 =?utf-8?B?eGU4bklCSWhGSGdkSWFMM1ZFaE1DTXhQU0JyM215RnBiT0dNUEFZQmFoeW5K?=
 =?utf-8?B?V29OQ3B4dkVmd1A2WEtiZzhBMEZwSHpVQjhUU3ljdWJvQUlqaG0vcnhaQ2FT?=
 =?utf-8?B?SGJiMlpPVHVJOHZjSW5pdVREZ2p4aFozcTB6RWFMTTFnM05qWWxLWkdxbWNy?=
 =?utf-8?B?RnIwVUMzNlBpdWlveXk1dUllZ0FHVTQrZDhKYW5RNDlCS1BvVE1ycHRGRDN0?=
 =?utf-8?B?WkdYNGtBVGFNanE1MThtYTUwRjJxMHhOMGV6emN2REtlNEtHQzdXSUFDUUFr?=
 =?utf-8?B?ZUNYYzluSUs5STl6d2ZpT0pmd2tjUUlna2RUMEN5T1VLUWVwb3JVZ1Nwcmpa?=
 =?utf-8?B?L0trVGdZSEJKc05la2VzSFZ2SUZKSXRKN1luQVRIZTNNM09ETnRjVmdnM2dr?=
 =?utf-8?B?dDhZdHUrcHJwQ092ZDBqT05TenZ4K3drcDQycHpQenJ3ZG5pNmtuenE3WVdL?=
 =?utf-8?B?MytxNnoxZCt6dnZvVFAxcDNBRkdBODFGeXp0TmtqR3dBRmNKeGF6SDJySlVB?=
 =?utf-8?B?Q0JtUjB0TlNWdXVBVFFXeEp3djQybTJ3WlU0RGRvZDN1K21QM3FqUWlndHNp?=
 =?utf-8?B?TGZUamxvc1NsWWduT3BHOU5hU3M0MkxFN1lZVFVWTzZ5WmNzODgxdHNUejZ1?=
 =?utf-8?B?am1icU4waVZHTmJXcUhLai9vUlVoSlhaNHFraGFaNWVveWQ0VmIyUDRqUWlp?=
 =?utf-8?B?aXgwNUFXR3o5clovSEZZekx5bnNvdnVPUTRqa1dUU2hkOTk2andBMnA3VUhI?=
 =?utf-8?Q?9UDimChrepUU50eDH3/El7gcCbYoSJuAAzLmtA6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6f6b11-424a-4d41-0bf9-08d921f52c80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:25:14.7924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CG683RtQZN88czZe2pUJa8Mns+OZZJRqVCw3N7tY6mmEcLmXmL0Jk4MwYUj/YKyUX5t5SzgH+3E4AXw4lTaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDUvMjgvMjAyMSA1OjU5IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBBbSAy
OC4wNS4yMSB1bSAxNzo1NCBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IERvbid0IGZsdXNoIGdhcnQg
Y2hhbmdlcyBhZnRlciByZWNvdmVyaW5nIGVhY2ggQk8gaW5zdGVhZAo+PiBkbyBpdCBhZnRlciBy
ZWNvdmVyaW5nIGFsbCB0aGUgQk9zLiBGbGlzaGluZyBnYXJ0IGFsc28gbmVlZGVkCj4+IGZvciBh
bWRncHVfdHRtX2FsbG9jX2dhcnQoKS4KPj4KPj4gdjM6IHJlbmFtZSBhbWRncHVfZ2FydF90bGJf
Zmx1c2goKSAtPiBhbWRncHVfZ2FydF9pbnZhbGlkYXRlX3RsYigpCj4+IHYyOiBhYnN0cmFjdCBv
dXQgZ2FydCB0bGIgZmx1c2hpbmcgbG9naWMgdG8gYW1kZ3B1X2dhcnQuYwo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jwqDCoMKgIHwgMjAgKysrKysrKysr
KysrKysrLS0tLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQu
aMKgwqDCoCB8wqAgMiArLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z3R0X21nci5jIHzCoCA2ICsrKysrKwo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmPCoMKgwqDCoCB8wqAgMSArCj4+IMKgIDQgZmlsZXMgY2hhbmdlZCwgMjMgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dhcnQuYwo+PiBpbmRleCA1NTYyYjVjOTBjMDMuLjk5MmI1OWMyOWRkNyAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYwo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jCj4+IEBAIC0z
MjIsMTYgKzMyMiwyNiBAQCBpbnQgYW1kZ3B1X2dhcnRfYmluZChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAKPj4gKmFkZXYsIHVpbnQ2NF90IG9mZnNldCwKPj4gwqDCoMKgwqDCoCBpZiAoIWFkZXYtPmdh
cnQucHRyKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Cj4+IC3CoMKgwqAgciA9
IGFtZGdwdV9nYXJ0X21hcChhZGV2LCBvZmZzZXQsIHBhZ2VzLCBkbWFfYWRkciwgZmxhZ3MsCj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPmdhcnQucHRyKTsKPj4gLcKgwqDCoCBpZiAo
cikKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiByOwo+PiArwqDCoMKgIHJldHVybiBhbWRncHVf
Z2FydF9tYXAoYWRldiwgb2Zmc2V0LCBwYWdlcywgZG1hX2FkZHIsIGZsYWdzLAo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPmdhcnQucHRyKTsKPj4gK30KPj4g
Kwo+PiArLyoqCj4+ICsgKiBhbWRncHVfZ2FydF9pbnZhbGlkYXRlX3RsYiAtIGludmFsaWRhdGUg
Z2FydCBUTEIKPj4gKyAqCj4+ICsgKiBAYWRldjogYW1kZ3B1IGRldmljZSBkcml2ZXIgcG9pbnRl
cgo+PiArICoKPj4gKyAqIEludmFsaWRhdGUgZ2FydCBUTEIgd2hpY2ggY2FuIGJlIHVzZSBhcyBh
IHdheSB0byBmbHVzaCBnYXJ0IGNoYW5nZXMKPj4gKyAqCj4+ICsgKi8KPj4gK3ZvaWQgYW1kZ3B1
X2dhcnRfaW52YWxpZGF0ZV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICt7Cj4+
ICvCoMKgwqAgaW50IGk7Cj4+Cj4+IMKgwqDCoMKgwqAgbWIoKTsKPj4gwqDCoMKgwqDCoCBhbWRn
cHVfYXNpY19mbHVzaF9oZHAoYWRldiwgTlVMTCk7Cj4+IMKgwqDCoMKgwqAgZm9yIChpID0gMDsg
aSA8IGFkZXYtPm51bV92bWh1YnM7IGkrKykKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9n
bWNfZmx1c2hfZ3B1X3RsYihhZGV2LCAwLCBpLCAwKTsKPj4gLcKgwqDCoCByZXR1cm4gMDsKPj4g
wqAgfQo+Pgo+PiDCoCAvKioKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nYXJ0LmggCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dhcnQuaAo+PiBpbmRleCBhMjVmZTk3YjAxOTYuLmUxMDQwMjIxOTdhZSAxMDA2NDQKPj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuaAo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5oCj4+IEBAIC02Niw1ICs2Niw1IEBA
IGludCBhbWRncHVfZ2FydF9tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIAo+PiB1aW50
NjRfdCBvZmZzZXQsCj4+IMKgIGludCBhbWRncHVfZ2FydF9iaW5kKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCB1aW50NjRfdCBvZmZzZXQsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaW50IHBhZ2VzLCBzdHJ1Y3QgcGFnZSAqKnBhZ2VsaXN0LAo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRtYV9hZGRyX3QgKmRtYV9hZGRyLCB1aW50NjRfdCBmbGFncyk7Cj4+IC0K
Pj4gK3ZvaWQgYW1kZ3B1X2dhcnRfaW52YWxpZGF0ZV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpOwo+PiDCoCAjZW5kaWYKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2d0dF9tZ3IuYwo+PiBpbmRleCA4ODYwNTQ1MzQ0YzcuLmIwMWJjMjM0NjA4MiAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYwo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ3R0X21nci5jCj4+IEBA
IC0yMDUsNiArMjA1LDcgQEAgdWludDY0X3QgYW1kZ3B1X2d0dF9tZ3JfdXNhZ2Uoc3RydWN0IAo+
PiB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuKQo+PiDCoMKgICovCj4+IMKgIGludCBhbWRncHVf
Z3R0X21ncl9yZWNvdmVyKHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuKQo+PiDCoCB7
Cj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBOVUxMOwo+PiDCoMKgwqDC
oMKgIHN0cnVjdCBhbWRncHVfZ3R0X21nciAqbWdyID0gdG9fZ3R0X21ncihtYW4pOwo+PiDCoMKg
wqDCoMKgIHN0cnVjdCBhbWRncHVfZ3R0X25vZGUgKm5vZGU7Cj4+IMKgwqDCoMKgwqAgc3RydWN0
IGRybV9tbV9ub2RlICptbV9ub2RlOwo+PiBAQCAtMjE2LDkgKzIxNywxNCBAQCBpbnQgYW1kZ3B1
X2d0dF9tZ3JfcmVjb3ZlcihzdHJ1Y3QgCj4+IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4pCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByID0gYW1kZ3B1X3R0bV9yZWNvdmVyX2dhcnQobm9kZS0+dGJv
KTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBicmVhazsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghYWRldikKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYWRldiA9IGFtZGdwdV90dG1fYWRldihub2RlLT50Ym8tPmJkZXYpOwo+Cj4g
Y29udGFpbmVyX29mKG1nciwgdHlwZW9mKCphZGV2KSwgbW1hbi5ndHRfbWdyKSBpcyBwcm9iYWJs
eSBhIGJpdCAKPiBjbGVhbmVyIHRoYW4gdGhpcy4KCgpUaGlzIHdhcyBib3RoZXJpbmcgbWUgYXMg
d2VsbCwgdGhhbmtzIGZvciB0aGlzIQoKCk5pcm1veQoKPgo+IENocmlzdGlhbi4KPgo+PiDCoMKg
wqDCoMKgIH0KPj4gwqDCoMKgwqDCoCBzcGluX3VubG9jaygmbWdyLT5sb2NrKTsKPj4KPj4gK8Kg
wqDCoCBpZiAoYWRldikKPj4gK8KgwqDCoMKgwqDCoMKgIGFtZGdwdV9nYXJ0X2ludmFsaWRhdGVf
dGxiKGFkZXYpOwo+PiArCj4+IMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+IMKgIH0KPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyAKPj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4gaW5kZXggYzBhZWYzMjcy
OTJhLi43ODY2NTBhNGE0OTMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMKPj4gQEAgLTEwMTQsNiArMTAxNCw3IEBAIGludCBhbWRncHVfdHRtX2FsbG9jX2dh
cnQoc3RydWN0IAo+PiB0dG1fYnVmZmVyX29iamVjdCAqYm8pCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiByOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pgo+PiArwqDCoMKg
wqDCoMKgwqAgYW1kZ3B1X2dhcnRfaW52YWxpZGF0ZV90bGIoYWRldik7Cj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCB0dG1fcmVzb3VyY2VfZnJlZShibywgJmJvLT5tZW0pOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgYm8tPm1lbSA9IHRtcDsKPj4gwqDCoMKgwqDCoCB9Cj4+IC0tIAo+PiAyLjMxLjEKPj4K
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
