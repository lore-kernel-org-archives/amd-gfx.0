Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA983C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7560B206FA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3vz5LLRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7560B206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3228C6E343;
	Wed, 19 Aug 2020 12:19:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E616E34E
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 12:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThbbzuOEFiIE0ad7dL0EZOADTLJQj5AcX4o9XQQ1Bgh5nNlN7fWjrojvgJlaEN8e/2R9KHW2e4I0q6QlmWlQ/iD3Eb7KmRguU64rkx+pIB3KUnXA+pKqslhVj9quZnYNjDnc5zKHNc1jm5lr4UjTSPC4D+spamK56XNLdPgnaF3sR8KVDYt9maMy38QM9glu/Cz5G6dj4xw22ghonbTFjiF5uIxqTfn9cQkT5BmVfCx0JZnF38idO+1HR3HSG3+k0myqexLhGRVMQiNAfm6bNoc2B3ig1tRl6WlEbDJjaY4Pz7tsBQ6FJDsaJqbd5n2giH2KJXFM9j2GXJ2RxzOmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sNMa01C/JjPMKBTnQ4Wqp3qlKXWsIJVxKHaffKY6Ps=;
 b=JKlt82jdAHNk5KnipX/lKj8M1zdqrbfR6AyGGcAFAo9olCehNYEOiHcjuMR2VdgKXpeRBk9eUhFw3efw5aOCNndaZPT0+RR8E2cbA0l3hNAzb9rbeiLOGWqI+o/FXL8sFzZhUy6j1atA5wDLBFjYqtea6FGgt0UeE2RTmAwWf7W9di3B8U31e3GJFVUOz7qywGKhd4t54AwcVS7iFq2gDgh/TON/YSzDL/QN91zHmbWf0Xam3ZgdSG33qOOje/14N1BduCyU6AFkwYj/B1FKGy5VT0djekwVrkgZkXQXzQxPrudLMDF5cdPZ16F7ot0ej/ke1aPxV1SHCuKfeShHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sNMa01C/JjPMKBTnQ4Wqp3qlKXWsIJVxKHaffKY6Ps=;
 b=3vz5LLRr0KH0BI5mBGykXW7NaKeOpOx+ZtIJSL29rhYz63RBxLQte1tQ4Xa0itfDWANoMKyjsnEIl8bcmJpadUj//ub6LvSjHeJqjegnQFuErD1/hBEt0SZjLv2WxLuvgmR1izp29O+aKDMJBY2Fg4xGRkmWRz4coSHQgfRCc1o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 12:19:26 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 12:19:26 +0000
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
 <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
 <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <3cc6b2fe-995d-581a-5e56-913a0cf60b42@amd.com>
Date: Wed, 19 Aug 2020 17:49:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.110.102) by
 MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 12:19:25 +0000
X-Originating-IP: [106.51.110.102]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38b11b8f-b311-4ab8-cffa-08d8443a1d46
X-MS-TrafficTypeDiagnostic: BY5PR12MB4273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4273D30F5AF9FA0A902C424BF25D0@BY5PR12MB4273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHBnuTqWVolWvinrHAN5srz6h3gE+ZHNXNi7sRAAqKHIUCumXaGZrfQL3m/7o5snfpxH4XbcOOjZieYOM3VdLTG4T69UsxpmFCsCWZ4a4x/tS4CDfAsE+vtzESTMGVDB6MxjlirKgrXDEwCCTxcK653tN7ZxgoBs6DHa0iardm9LIjs8aNpUkuLQQjLcmcVARnI8CFyTDslsyUrcRKn1rgvYd4hRASuuHa6H226gNDC0fzS7lgT+dh0m2sD98sXxCxf/A9GDyVZWWWeyqi9cvn+aBpr6JVexltY5nLlxIp8UEb5DXopDyzRTKGq3NZcFzXondGtcj5gwUUENHuYP53K1UWxOvEBpnKlLNSDm5Igr64dcGhTX1W7ph1Jrlj59
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(6666004)(1006002)(31686004)(478600001)(31696002)(16576012)(86362001)(316002)(4326008)(36756003)(53546011)(2616005)(15650500001)(55236004)(66574015)(83380400001)(66946007)(66556008)(8936002)(66476007)(186003)(44832011)(2906002)(52116002)(26005)(6486002)(8676002)(16526019)(5660300002)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nEJcc0s6BUq957e7YQFJuRVz6Q9owwDLnEfdE5K9kkgUHzblNocENnQCGPB7tO+4EkICIAacWSg1YqI+F1JtbvM75X+lWqu9jLuX8Og0HyCPxd0kAI8SM4fZBhMSpNXnj9/2Me7COr/3TPTJt4dVqcr3S3RdW0JbvGE49HOWqHKsAb713nTebfw3IHEBKfAyaypUO5j7haVtvlUmsWdHk0SnnHUL6/BNSq8YCu0Gz3NjBdsGIhz7DLzSQU5mhE1estHWqt2zYRveXMOvaCIhl1NksuOGndYCyQUPj8IlI1YZRRcAopRxOo9sEn2AJBjlOvHCYnFUUOms4YXz9zmvcmWFXKqj/wBTqQ2NCc2vY7hRKTIxwCTR5HbMLUCMQc6uR5Kdc7+mW7v2CSOT/bXF5vu1rpqXnGIHchODr9jHl8fewwJ4wNfQGNWH9yqS9KBUr0MNgsvVko4IY8JwfA8FQFJZn2Y7RsfiUQgMjyamhuazkYo8E94/ntdGAtvRbuTJF846lnI68WGdyOvnwW0qDLCHwYZCaqfBlULc73GuZrTt/jwtaPIUHrss5FdAKrBUh19tGKLA+rtLT9nHPBMV19NJEHApfj1kDIMJapc0C8NeYg76xu7HIk5Iv/eLaoMYHfGu4iN/WGPzXe5k891Ijg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b11b8f-b311-4ab8-cffa-08d8443a1d46
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 12:19:26.5955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJeWqRjqHkFKBJ19FnvT0bXpSBncDFcr/LSr/op1/7lvdWgE4GWdNSR16ADZCggFfxDVBNj6Lty+Hmz1f999Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDE5LzA4LzIwIDU6MzggcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTkuMDgu
MjAgdW0gMTM6NTIgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IE9uIDEzLzA4LzIwIDE6Mjgg
cG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxMy4wOC4yMCB1bSAwNTowNCBzY2hy
aWViIFNoYXNoYW5rIFNoYXJtYToKPj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgdHJhY2UgZXZl
bnQgdG8gdHJhY2sgdGhlIFBURSB1cGRhdGUKPj4+PiBldmVudHMuIFRoaXMgc3BlY2lmaWMgZXZl
bnQgd2lsbCBwcm92aWRlIGluZm9ybWF0aW9uIGxpa2U6Cj4+Pj4gLSBzdGFydCBhbmQgZW5kIG9m
IHZpcnR1YWwgbWVtb3J5IG1hcHBpbmcKPj4+PiAtIEhXIGVuZ2luZSBmbGFncyBmb3IgdGhlIG1h
cAo+Pj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFwcGluZwo+Pj4+Cj4+Pj4gVGhpcyB3aWxs
IGJlIHBhcnRpY3VsYXJseSB1c2VmdWwgZm9yIG1lbW9yeSBwcm9maWxpbmcgdG9vbHMKPj4+PiAo
bGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZSBldmVu
dHMuCj4+Pj4KPj4+PiBWMjogQWRkZWQgcGh5c2ljYWwgYWRkcmVzcyBsb29rdXAgbG9naWMgaW4g
dHJhY2UgcG9pbnQKPj4+PiBWMzogc3dpdGNoIHRvIHVzZSBfX2R5bmFtaWNfYXJyYXkKPj4+PiAg
ICAgICBhZGRlZCBucHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKPj4+PiAgICAg
ICBhZGRlZCBwYWdlIHNpemUgaW4gdGhlIGFyZyBsaXN0Cj4+Pj4gVjQ6IEFkZHJlc3NlZCBDaHJp
c3RpYW4ncyByZXZpZXcgY29tbWVudHMKPj4+PiAgICAgICBhZGQgc3RhcnQvZW5kIGluc3RlYWQg
b2Ygc2VnCj4+Pj4gICAgICAgdXNlIGluY3IgaW5zdGVhZCBvZiBwYWdlX3N6IHRvIGJlIGFjY3Vy
YXRlCj4+Pj4KPj4+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+Pj4+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+
Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1h
QGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3RyYWNlLmggfCAzNyArKysrKysrKysrKysrKysrKysrKysrKwo+Pj4+ICAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICAgIHwgIDkgKysrKy0tCj4+Pj4gICAgMiBm
aWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4+PiBpbmRleCA2M2U3
MzRhMTI1ZmIuLmRmMTJjZjg0NjZjMiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4gQEAgLTMyMSw2ICszMjEsNDMgQEAgREVGSU5FX0VW
RU5UKGFtZGdwdV92bV9tYXBwaW5nLCBhbWRncHVfdm1fYm9fY3MsCj4+Pj4gICAgCSAgICBUUF9B
UkdTKG1hcHBpbmcpCj4+Pj4gICAgKTsKPj4+PiAgICAKPj4+PiArVFJBQ0VfRVZFTlQoYW1kZ3B1
X3ZtX3VwZGF0ZV9wdGVzLAo+Pj4+ICsJICAgIFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBk
YXRlX3BhcmFtcyAqcCwKPj4+PiArCQkgICAgIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBlbmQs
Cj4+Pj4gKwkJICAgICB1bnNpZ25lZCBpbnQgbnB0ZXMsIHVpbnQ2NF90IGRzdCwKPj4+PiArCQkg
ICAgIHVpbnQ2NF90IGluY3IsIHVpbnQ2NF90IGZsYWdzKSwKPj4+PiArCVRQX0FSR1MocCwgc3Rh
cnQsIGVuZCwgbnB0ZXMsIGRzdCwgaW5jciwgZmxhZ3MpLAo+Pj4+ICsJVFBfU1RSVUNUX19lbnRy
eSgKPj4+PiArCQkJIF9fZmllbGQodTY0LCBzdGFydCkKPj4+PiArCQkJIF9fZmllbGQodTY0LCBl
bmQpCj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgZmxhZ3MpCj4+Pj4gKwkJCSBfX2ZpZWxkKHVuc2ln
bmVkIGludCwgbnB0ZXMpCj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgaW5jcikKPj4+PiArCQkJIF9f
ZHluYW1pY19hcnJheSh1NjQsIGRzdCwgbnB0ZXMpCj4+PiBBcyBkaXNjdXNzZWQgd2l0aCB0aGUg
dHJhY2Ugc3Vic3lzdGVtIG1haW50YWluZXIgd2UgbmVlZCB0byBhZGQgdGhlIHBpZAo+Pj4gYW5k
IHByb2JhYmx5IHRoZSBWTSBjb250ZXh0IElEIHdlIHVzZSBoZXJlIHRvIGlkZW50aWZ5IHRoZSB1
cGRhdGVkIFZNLgo+Pj4KPj4+IENocmlzdGlhbi4KPj4gSSBwcmludGVkIGJvdGggdm0tPnRhc2tf
aW5mby5waWQgVnMgY3VycmVudC0+cGlkIGZvciB0ZXN0aW5nLCBhbmQgSSBjYW4gc2VlIGRpZmZl
cmVudCB2YWx1ZXMgY29taW5nIG91dCBvZiAuCj4+Cj4+IGdub21lLXNoZWxsLTIxMTTCoCBbMDEx
XcKgwqDCoCA0MS44MTI4OTQ6IGFtZGdwdV92bV91cGRhdGVfcHRlczogc3RhcnQ6MHgwODAwMTAy
ZTgwIGVuZDoweDA4MDAxMDJlODIsIGZsYWdzOjB4ODAsIGluY3I6NDA5NiwgcGlkPTIxMjggdm1p
ZD0wIGNwaWQ9MjExNAo+Pgo+PiBwaWQgaXMgdm0tPnRhc2tfaW5mby5waWQ9MjEyOCB3aGVyZWFz
IGNwaWQ9MjExNCBpcyBjdXJyZW50LnBpZC4KPj4KPj4gV2hpY2ggaXMgdGhlIG9uZSB3ZSB3YW50
IHRvIHNlbmQgd2l0aCB0aGUgZXZlbnQgPwo+IFRoYXQgaXMgdm0tPnRhc2tfaW5mby5waWQsIHNp
bmNlIHRoaXMgaXMgdGhlIFBJRCB3aGljaCBpcyB1c2luZyB0aGUgVk0gCj4gZm9yIGNvbW1hbmQg
c3VibWlzc2lvbi4KZ290IGl0Lgo+PiBUcmFjZSBldmVudCBieSBkZWZhdWx0IHNlZW1zIHRvIGJl
IGFkZGluZyB0aGUgcHJvY2VzcyBuYW1lIGFuZCBpZCBhdCB0aGUgaGVhZGVyIG9mIHRoZSBldmVu
dCAoZ25vbWUtc2hlbGwtMjExNCksIHdoaWNoIGlzIHNhbWUgYXMgY3VycmVudC5waWQKPj4KPj4K
Pj4gQWxzbywgaXMgaXQgb2sgdG8gZXh0cmFjdCB2bWlkIGZyb20gam9iLT52bWlkID8KPiBPbmx5
IGluIHRyYWNlX2FtZGdwdV92bV9ncmFiX2lkKCksIGluIGFsbCBvdGhlciBjYXNlcyBpdCdzIHBy
b2JhYmx5IG5vdCAKPiBhc3NpZ25lZCB5ZXQuCgpPaywgbGV0IG1lIGNoZWNrIGhvdyBjYW4gd2Ug
Z2V0IHZtaWQgZnJvbSB0aGlzIGNvbnRleHQgd2UgYXJlIHNlbmRpbmcgdGhlIGV2ZW50IGZyb20u
IE9yIG1heWJlIEkgd2Ugc2hvdWxkwqAga2VlcCBWNSB3aXRoIHBpZCBvbmx5LCBhbmQgbGF0ZXIg
c2VuZCBhIHNlcGFyYXRlIHBhdGNoIHRvIGFkZCB2bWlkID8KCi0gU2hhc2hhbmsKCj4gQ2hyaXN0
aWFuLgo+Cj4+Cj4+IFJlZ2FyZHMKPj4KPj4gU2hhc2hhbmsKPj4KPj4+PiArCSksCj4+Pj4gKwo+
Pj4+ICsJVFBfZmFzdF9hc3NpZ24oCj4+Pj4gKwkJCXVuc2lnbmVkIGludCBpOwo+Pj4+ICsKPj4+
PiArCQkJX19lbnRyeS0+c3RhcnQgPSBzdGFydDsKPj4+PiArCQkJX19lbnRyeS0+ZW5kID0gZW5k
Owo+Pj4+ICsJCQlfX2VudHJ5LT5mbGFncyA9IGZsYWdzOwo+Pj4+ICsJCQlfX2VudHJ5LT5pbmNy
ID0gaW5jcjsKPj4+PiArCQkJX19lbnRyeS0+bnB0ZXMgPSBucHRlczsKPj4+PiArCQkJZm9yIChp
ID0gMDsgaSA8IG5wdGVzOyArK2kpIHsKPj4+PiArCQkJCXU2NCBhZGRyID0gcC0+cGFnZXNfYWRk
ciA/IGFtZGdwdV92bV9tYXBfZ2FydCgKPj4+PiArCQkJCQlwLT5wYWdlc19hZGRyLCBkc3QpIDog
ZHN0Owo+Pj4+ICsKPj4+PiArCQkJCSgodTY0ICopX19nZXRfZHluYW1pY19hcnJheShkc3QpKVtp
XSA9IGFkZHI7Cj4+Pj4gKwkJCQlkc3QgKz0gaW5jcjsKPj4+PiArCQkJfQo+Pj4+ICsJKSwKPj4+
PiArCVRQX3ByaW50aygic3RhcnQ6MHglMDEwbGx4IGVuZDoweCUwMTBsbHgsIGZsYWdzOjB4JWxs
eCwgaW5jcjolbGx1LCIKPj4+PiArCQkgICIgZHN0OlxuJXMiLCBfX2VudHJ5LT5zdGFydCwgX19l
bnRyeS0+ZW5kLCBfX2VudHJ5LT5mbGFncywKPj4+PiArCQkgIF9fZW50cnktPmluY3IsIF9fcHJp
bnRfYXJyYXkoCj4+Pj4gKwkJICBfX2dldF9keW5hbWljX2FycmF5KGRzdCksIF9fZW50cnktPm5w
dGVzLCA4KSkKPj4+PiArKTsKPj4+PiArCj4+Pj4gICAgVFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX3Nl
dF9wdGVzLAo+Pj4+ICAgIAkgICAgVFBfUFJPVE8odWludDY0X3QgcGUsIHVpbnQ2NF90IGFkZHIs
IHVuc2lnbmVkIGNvdW50LAo+Pj4+ICAgIAkJICAgICB1aW50MzJfdCBpbmNyLCB1aW50NjRfdCBm
bGFncywgYm9vbCBkaXJlY3QpLAo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCj4+Pj4gaW5kZXggNzFlMDA1Y2YyOTUyLi5iNWRiYjVlOGJjNjEgMTAwNjQ0Cj4+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4+IEBAIC0xNTEzLDE3ICsxNTEz
LDIyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1f
dXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+Pj4+ICAgIAkJZG8gewo+Pj4+ICAgIAkJCXVpbnQ2NF90
IHVwZF9lbmQgPSBtaW4oZW50cnlfZW5kLCBmcmFnX2VuZCk7Cj4+Pj4gICAgCQkJdW5zaWduZWQg
bnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQpID4+IHNoaWZ0Owo+Pj4+ICsJCQl1aW50NjRf
dCB1cGRfZmxhZ3MgPSBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhmcmFnKTsKPj4+PiAgICAKPj4+
PiAgICAJCQkvKiBUaGlzIGNhbiBoYXBwZW4gd2hlbiB3ZSBzZXQgaGlnaGVyIGxldmVsIFBEcyB0
bwo+Pj4+ICAgIAkJCSAqIHNpbGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4KPj4+PiAgICAJCQkg
Ki8KPj4+PiAgICAJCQlucHRlcyA9IG1heChucHRlcywgMXUpOwo+Pj4+ICsKPj4+PiArCQkJdHJh
Y2VfYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHBhcmFtcywgZnJhZ19zdGFydCwgdXBkX2VuZCwKPj4+
PiArCQkJCQkJICAgIG5wdGVzLCBkc3QsIGluY3IsCj4+Pj4gKwkJCQkJCSAgICB1cGRfZmxhZ3Mp
Owo+Pj4+ICAgIAkJCWFtZGdwdV92bV91cGRhdGVfZmxhZ3MocGFyYW1zLCBwdCwgY3Vyc29yLmxl
dmVsLAo+Pj4+ICAgIAkJCQkJICAgICAgIHBlX3N0YXJ0LCBkc3QsIG5wdGVzLCBpbmNyLAo+Pj4+
IC0JCQkJCSAgICAgICBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhmcmFnKSk7Cj4+Pj4gKwkJCQkJ
ICAgICAgIHVwZF9mbGFncyk7Cj4+Pj4gICAgCj4+Pj4gICAgCQkJcGVfc3RhcnQgKz0gbnB0ZXMg
KiA4Owo+Pj4+IC0JCQlkc3QgKz0gKHVpbnQ2NF90KW5wdGVzICogQU1ER1BVX0dQVV9QQUdFX1NJ
WkUgPDwgc2hpZnQ7Cj4+Pj4gKwkJCWRzdCArPSBucHRlcyAqIGluY3I7Cj4+Pj4gICAgCj4+Pj4g
ICAgCQkJZnJhZ19zdGFydCA9IHVwZF9lbmQ7Cj4+Pj4gICAgCQkJaWYgKGZyYWdfc3RhcnQgPj0g
ZnJhZ19lbmQpIHsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
