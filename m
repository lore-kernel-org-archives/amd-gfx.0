Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B5C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447D2206EE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447D2206EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C290E6EE86;
	Wed, 13 Nov 2019 22:26:09 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B64D06EE86
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ87Fo96qbtsKXjxHLki50NCUo3zqm5NEB2pJoBRkXsdjqqkpH0JClBsloFeyw4uF+1RMVDPck6lbGyDmuT+pP2byjRoQSJSkZy9nG+pSeCsiyEoin0d5zMG7cHi/Q1YrNrSjmE6aOtFVHmL/MlRs1dRc1pO/idX4z0Bkpy+o5B3Bo7xRLbKmvwOqrxmBiGs9xOSueo7Z0U4lDDeXfixcA7XArprmFB4O2tEnNptIhs4SKi+FeZh/9dvRyIKEWC2vmaxvYTM32xtJk5fSV5FQrZY6Posjae+McCUUtBcVKe8AV6ummwdQGAraE/kpRHbuR9ED1RNJ4KhKDls849p0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPxrAzPIC/K/XJDa2Z6o7Ce0xNvrJjN26RkyIQ1MTws=;
 b=nZ91Gcp6ZAN03HIR5JJ+pvnG7NCA7cvhRUA7qFMR440ziCGMGCKOThqZAOfwjsrzTPIgNiHIKEnB+FV2uEYsHdg8wk8j4FgN28b7ThFVgM1myQHg1VuIFRZGA0rUpTnldsG7AeNmAz5eX35Zlg6UC/jczrcZmLCKVKUv8dSGLTYpglbm1S7UFlNliNamTcgYa5rlISM+4kQeFXmvFMDmQBtEDCX91wnJepL8CI8OsfDga/CJFr3VKzgnZRHjRiQK/r0sz4Q6234NSfwmqTwirpz7hNTZP35lyL+yUGcut8bRSoe9rwJ4fRY70v5nceg3RtTGwH603P4llgEd7MddOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6SPR01MB0101.namprd12.prod.outlook.com (20.180.57.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 22:26:06 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 22:26:06 +0000
Subject: Re: [PATCH] drm/amdkfd: Rename kfd_kernel_queue_*.c to
 kfd_packet_manager_*.c
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191113220946.32529-1-Yong.Zhao@amd.com>
 <5105f095-d0b9-cd87-180b-4a378c775d46@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <ae6b718d-41d8-c2d2-875a-9ffa0e23dd26@amd.com>
Date: Wed, 13 Nov 2019 17:26:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <5105f095-d0b9-cd87-180b-4a378c775d46@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::46) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdcc373b-0170-4289-4fd7-08d76888796f
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0101:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6SPR01MB010133927E13A9CEF1AE8E70F0760@DM6SPR01MB0101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(199004)(11346002)(99286004)(58126008)(316002)(50466002)(65806001)(478600001)(66946007)(66476007)(66556008)(2486003)(23676004)(446003)(476003)(486006)(186003)(86362001)(76176011)(53546011)(52116002)(66066001)(2616005)(65956001)(44832011)(14454004)(386003)(5660300002)(25786009)(26005)(6506007)(4001150100001)(229853002)(7736002)(81166006)(305945005)(81156014)(6486002)(31686004)(36756003)(6116002)(3846002)(8676002)(31696002)(8936002)(2906002)(6246003)(6512007)(47776003)(6436002)(2870700001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6SPR01MB0101;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1UxoMbTBUf3qgQW90a+NejJ2c/7eMsAYrN3uUjdanKSeH+Yd45DZ1KWDOaxgSU5yt/ELkVAh8kmqEq+zYYwZ8tKRDj2xrG0s9isbpQiTuHQsiTuS8j2vC8Hek+NYhNWHo7m6e/hPXE9BkUqYkM8p27FfvfyOwG404Nq6DOOITLK98jrSeVux+lUj/f7vLoY4RTL+MCav+rCAVzx9oWPGN1NjXPhJiGbpa9wDwEjsgv2ADyB04SpFdFzxjwacP0+ZQHkYpj631O0iWrOJeQ//xNVnIrDHFExMAQaS5lHnCMo5YT4NPeYRi7/hk/deou4Zn8ywRyFG4OSWXynCkTiWRYNWFRq59ZCrIe83mI3kVA0Qod/OVl/4J6CIJuvb92ykjC30H1XEhvIwTqJiy9oLOXHBhQKkMdKDqjejq8L6/lsWTlGby6tzkKl3lBGZCbd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcc373b-0170-4289-4fd7-08d76888796f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 22:26:06.0232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57Ov+aB3ytyPvg+cX2CJFRFibRvMlt0A/KljqPl/uYjHgTS7gs4DFqdA73C8NMyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB0101
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPxrAzPIC/K/XJDa2Z6o7Ce0xNvrJjN26RkyIQ1MTws=;
 b=4Jb+zv8Bl/HhIxT+TDQnrhzntfNuU+DHg3mwiW+t2FFNYuAdzhoZS24hoBll7hL/JK7QLKLV4+Hdyz+BBg8XkSsvWMfuZqdRS5Z5iA/tn40uV3QGtsHp9qqufVC1ZxiKyAGsSr7GULnXRtK+4GQZPDr82EHUFqCj29higGXgU44=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Message-ID: <20191113222604.2BJVeEdPqAVA5U4EkSjmXmN40jRMfwMOj4TtBhoWWEk@z>

T2gsIEkgZGlkIG5vdCByZWFsaXplIHRoZSBwYXJ0IGluc2lkZSBvZiB0aGUgZmlsZS4gSSB0aGlu
ayB2OS0+YWkgaXMgCmJldHRlciwgYmVjYXVzZSB0aGUgcGFja2V0IGZvcm1hdCBoZWFkZXIgdXNl
cyBhaS4gQWxzbyB2OSB3aWxsIGdpdmUgCnBlb3BsZSBhbiBpbXByZXNzaW9uIG9mIGdmeDkuCgpZ
b25nCgpPbiAyMDE5LTExLTEzIDU6MTkgcC5tLiwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gT24g
MjAxOS0xMS0xMyA1OjA5IHAubS4sIFlvbmcgWmhhbyB3cm90ZToKPj4gQWZ0ZXIgdGhlIHJlY2Vu
dCBjbGVhbnVwLCB0aGUgZnVuY3Rpb25hbGl0aWVzIHByb3ZpZGVkIGJ5IHRoZSBwcmV2aW91cwo+
PiBrZmRfa2VybmVsX3F1ZXVlXyouYyBhcmUgYWN0dWFsbHkgYWxsIHBhY2tldCBtYW5hZ2VyIHJl
bGF0ZWQuIFNvIHJlbmFtZQo+PiB0aGVtIHRvIHJlZmxlY3QgdGhhdC4KPj4KPj4gQ2hhbmdlLUlk
OiBJNjU0NGNjYjM4ZGE4MjdjNzQ3NTQ0YzA3ODdhYTk0OWRmMjBlZGJiMAo+PiBTaWduZWQtb2Zm
LWJ5OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQvTWFrZWZpbGUgfCA0ICsrLS0KPj4gwqAgLi4uL2FtZGtmZC97a2Zk
X2tlcm5lbF9xdWV1ZV92OS5jID0+IGtmZF9wYWNrZXRfbWFuYWdlcl9haS5jfSB8IDAKPj4gwqAg
Li4uL2FtZGtmZC97a2ZkX2tlcm5lbF9xdWV1ZV92aS5jID0+IGtmZF9wYWNrZXRfbWFuYWdlcl92
aS5jfSB8IDAKPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4+IMKgIHJlbmFtZSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC97a2ZkX2tlcm5l
bF9xdWV1ZV92OS5jID0+IAo+PiBrZmRfcGFja2V0X21hbmFnZXJfYWkuY30gKDEwMCUpCj4+IMKg
IHJlbmFtZSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC97a2ZkX2tlcm5lbF9xdWV1ZV92aS5j
ID0+IAo+PiBrZmRfcGFja2V0X21hbmFnZXJfdmkuY30gKDEwMCUpCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9NYWtlZmlsZSAKPj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9NYWtlZmlsZQo+PiBpbmRleCBmOTNhMTYzNzIzMjUuLjU1YmZlY2YwNDIz
OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvTWFrZWZpbGUKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvTWFrZWZpbGUKPj4gQEAgLTM4LDkgKzM4
LDkgQEAgQU1ES0ZEX0ZJTEVTwqDCoMKgIDo9ICQoQU1ES0ZEX1BBVEgpL2tmZF9tb2R1bGUubyBc
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAkKEFNREtGRF9QQVRIKS9rZmRfbXFkX21hbmFnZXJfdjku
byBcCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAkKEFNREtGRF9QQVRIKS9rZmRfbXFkX21hbmFnZXJf
djEwLm8gXAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgJChBTURLRkRfUEFUSCkva2ZkX2tlcm5lbF9x
dWV1ZS5vIFwKPj4gLcKgwqDCoMKgwqDCoMKgICQoQU1ES0ZEX1BBVEgpL2tmZF9rZXJuZWxfcXVl
dWVfdmkubyBcCj4+IC3CoMKgwqDCoMKgwqDCoCAkKEFNREtGRF9QQVRIKS9rZmRfa2VybmVsX3F1
ZXVlX3Y5Lm8gXAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgJChBTURLRkRfUEFUSCkva2ZkX3BhY2tl
dF9tYW5hZ2VyLm8gXAo+PiArwqDCoMKgwqDCoMKgwqAgJChBTURLRkRfUEFUSCkva2ZkX3BhY2tl
dF9tYW5hZ2VyX3ZpLm8gXAo+PiArwqDCoMKgwqDCoMKgwqAgJChBTURLRkRfUEFUSCkva2ZkX3Bh
Y2tldF9tYW5hZ2VyX2FpLm8gXAo+Cj4gVGhpcyBuYW1pbmcgY29udmVudGlvbiBpcyBpbmNvbnNp
c3RlbnQgd2l0aCB0aGUgcmVzdCBvZiBLRkQuIFdlIHVzZSAKPiBfdjksIG5vdCBfYWkuIEFsc28g
dGhlIGZ1bmN0aW9uIHMgaW5zaWRlIHRoaXMgZmlsZSBhcmUgbmFtZWQgX3Y5LiBJZiAKPiB3ZSBk
ZWNpZGUgdG8gY2hhbmdlIHRoYXQgbmFtaW5nIGNvbnZlbnRpb24sIGl0IHNob3VsZCBub3QgYmUg
Cj4gYWNjaWRlbnRhbCBhbmQgcGllY2UtbWVhbC4gSXQgc2hvdWxkIGJlIGRlbGliZXJhdGUgYW5k
IGNvbXByZWhlbnNpdmUuCj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPgo+PiAkKEFNREtGRF9Q
QVRIKS9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLm8gXAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
JChBTURLRkRfUEFUSCkva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLm8gXAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgJChBTURLRkRfUEFUSCkva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyX2Npay5vIFwK
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVl
dWVfdjkuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFn
ZXJfYWkuYwo+PiBzaW1pbGFyaXR5IGluZGV4IDEwMCUKPj4gcmVuYW1lIGZyb20gZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92OS5jCj4+IHJlbmFtZSB0byBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfYWkuYwo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92aS5jIAo+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFuYWdlcl92aS5jCj4+
IHNpbWlsYXJpdHkgaW5kZXggMTAwJQo+PiByZW5hbWUgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlX3ZpLmMKPj4gcmVuYW1lIHRvIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFuYWdlcl92aS5jCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
