Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32280C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEB32067C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZDlXa6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEB32067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8433589AB9;
	Wed, 19 Aug 2020 13:30:51 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D20889AB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 13:30:50 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id f7so21565448wrw.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7suHcnLQOWjnbQK4ZkK51sJ5YjJnE5p5xGyqROewWpc=;
 b=aZDlXa6cPiNpV5+ehGM9B/VUHSsLFRwnrf5rQZlLjjMUS3pGLRU8dMK7GxxpeqIOBn
 mUZQ9De8Y94PALDg2tzAoUH4lZgIXsQJcUAeC8/P8KBZ2E1PVrMDhBVlRzdwYwM3rVV7
 thZMUoOD3OI6bOuampAPeUlt1t9L0nV/6SUv+cOZ213R4cZ5viFmh/1ob2wvqPyuP/7H
 HWZB755HNnj2Gd79x6DPsdkS5T8k/JB6HSJpW6wAokdYjJS6dirx6FUfuT/IW0cH91ZS
 5UEuCeUHaXXB0YpbZdakhpriZcmdJNxDvulzsiByRtZNObAviFluw9bvbTwASvJ2Cm32
 8CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=7suHcnLQOWjnbQK4ZkK51sJ5YjJnE5p5xGyqROewWpc=;
 b=tp8KZrPqHx/Xjfzk86aIGlmP58U4bMQpBAz723iUW0NvCpsYiHdOsnYxmVsyiIxzt+
 +eMydJIETgRlfADIWo42lT5huS8pKbqhmJMFT4xVrb7kYyH9appP6No50G37QpSLhGw9
 hS8OQ3hg76vgI6RBf16IHMkv1yp5YFDeHZy4ekX6S5zXozFQqI+dImMRKGYbWKCNn831
 weJJ7stGrkhiZuz2+b4045Kp7L64N8Jl2WR94SFJMu6ojdxW+3o68eyYIZX8mQYYyO+E
 j4LXJDFw7TogZn+Uq2d9MRfPS0ErtobJXojqXR6ijjV1v8/fiHCQH/tHp82XLl7sLPxz
 HjQg==
X-Gm-Message-State: AOAM530QIhxTNNs7T9P7Fc83PlyXuf90dabgHENbpRDW+IW47Dt7lCNj
 Z3bmWS802TuM/1sQCrisFAQ=
X-Google-Smtp-Source: ABdhPJwTJ7QLr7Kh1lxEE/MsRUbUghK484ME8Zf3e3CJ9l0qkljtcX/DZPfg78leMtBYXZJGlYvahA==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr23207202wrj.380.1597843849174; 
 Wed, 19 Aug 2020 06:30:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b11sm36536741wrq.32.2020.08.19.06.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 06:30:48 -0700 (PDT)
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
 <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
 <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
 <3cc6b2fe-995d-581a-5e56-913a0cf60b42@amd.com>
 <42ef3112-81fb-d58b-4335-c19655f5db07@gmail.com>
 <99ecca3a-c2bb-f11a-6786-e0dfb853ba88@amd.com>
 <451e4ec1-40a8-f00e-d4c7-cbb34927062c@amd.com>
 <0a707d0d-935e-464a-388a-e25c9c0c6c41@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eea173dc-459b-5653-47f8-a563724391d6@gmail.com>
Date: Wed, 19 Aug 2020 15:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0a707d0d-935e-464a-388a-e25c9c0c6c41@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTkuMDguMjAgdW0gMTU6MDggc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gT24gMTkvMDgv
MjAgNjozNCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTkuMDguMjAgdW0gMTQ6
Mzcgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+PiBPbiAxOS8wOC8yMCA2OjAzIHBtLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDE5LjA4LjIwIHVtIDE0OjE5IHNjaHJpZWIgU2hh
c2hhbmsgU2hhcm1hOgo+Pj4+PiBPbiAxOS8wOC8yMCA1OjM4IHBtLCBDaHJpc3RpYW4gS8O2bmln
IHdyb3RlOgo+Pj4+Pj4gQW0gMTkuMDguMjAgdW0gMTM6NTIgc2NocmllYiBTaGFzaGFuayBTaGFy
bWE6Cj4+Pj4+Pj4gT24gMTMvMDgvMjAgMToyOCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
Pj4+Pj4+Pj4gQW0gMTMuMDguMjAgdW0gMDU6MDQgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+
Pj4+Pj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgdHJhY2UgZXZlbnQgdG8gdHJhY2sgdGhlIFBU
RSB1cGRhdGUKPj4+Pj4+Pj4+IGV2ZW50cy4gVGhpcyBzcGVjaWZpYyBldmVudCB3aWxsIHByb3Zp
ZGUgaW5mb3JtYXRpb24gbGlrZToKPj4+Pj4+Pj4+IC0gc3RhcnQgYW5kIGVuZCBvZiB2aXJ0dWFs
IG1lbW9yeSBtYXBwaW5nCj4+Pj4+Pj4+PiAtIEhXIGVuZ2luZSBmbGFncyBmb3IgdGhlIG1hcAo+
Pj4+Pj4+Pj4gLSBwaHlzaWNhbCBhZGRyZXNzIGZvciBtYXBwaW5nCj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4gVGhpcyB3aWxsIGJlIHBhcnRpY3VsYXJseSB1c2VmdWwgZm9yIG1lbW9yeSBwcm9maWxpbmcg
dG9vbHMKPj4+Pj4+Pj4+IChsaWtlIFJNVikgd2hpY2ggYXJlIG1vbml0b3JpbmcgdGhlIHBhZ2Ug
dGFibGUgdXBkYXRlIGV2ZW50cy4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBWMjogQWRkZWQgcGh5c2lj
YWwgYWRkcmVzcyBsb29rdXAgbG9naWMgaW4gdHJhY2UgcG9pbnQKPj4+Pj4+Pj4+IFYzOiBzd2l0
Y2ggdG8gdXNlIF9fZHluYW1pY19hcnJheQo+Pj4+Pj4+Pj4gICAgICAgICAgYWRkZWQgbnB0ZXMg
aW50IHRoZSBUUHByaW50IGFyZ3VtZW50cyBsaXN0Cj4+Pj4+Pj4+PiAgICAgICAgICBhZGRlZCBw
YWdlIHNpemUgaW4gdGhlIGFyZyBsaXN0Cj4+Pj4+Pj4+PiBWNDogQWRkcmVzc2VkIENocmlzdGlh
bidzIHJldmlldyBjb21tZW50cwo+Pj4+Pj4+Pj4gICAgICAgICAgYWRkIHN0YXJ0L2VuZCBpbnN0
ZWFkIG9mIHNlZwo+Pj4+Pj4+Pj4gICAgICAgICAgdXNlIGluY3IgaW5zdGVhZCBvZiBwYWdlX3N6
IHRvIGJlIGFjY3VyYXRlCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Pj4+Pj4+IENjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Pj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPgo+Pj4+Pj4+Pj4g
LS0tCj4+Pj4+Pj4+PiAgICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJh
Y2UuaCB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrCj4+Pj4+Pj4+PiAgICAgICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgICB8ICA5ICsrKystLQo+Pj4+Pj4+Pj4g
ICAgICAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHJhY2UuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFj
ZS5oCj4+Pj4+Pj4+PiBpbmRleCA2M2U3MzRhMTI1ZmIuLmRmMTJjZjg0NjZjMiAxMDA2NDQKPj4+
Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+
Pj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+
Pj4+Pj4+Pj4gQEAgLTMyMSw2ICszMjEsNDMgQEAgREVGSU5FX0VWRU5UKGFtZGdwdV92bV9tYXBw
aW5nLCBhbWRncHVfdm1fYm9fY3MsCj4+Pj4+Pj4+PiAgICAgICAJICAgIFRQX0FSR1MobWFwcGlu
ZykKPj4+Pj4+Pj4+ICAgICAgICk7Cj4+Pj4+Pj4+PiAgICAgICAKPj4+Pj4+Pj4+ICtUUkFDRV9F
VkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4+Pj4+Pj4+PiArCSAgICBUUF9QUk9UTyhzdHJ1
Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCj4+Pj4+Pj4+PiArCQkgICAgIHVpbnQ2NF90
IHN0YXJ0LCB1aW50NjRfdCBlbmQsCj4+Pj4+Pj4+PiArCQkgICAgIHVuc2lnbmVkIGludCBucHRl
cywgdWludDY0X3QgZHN0LAo+Pj4+Pj4+Pj4gKwkJICAgICB1aW50NjRfdCBpbmNyLCB1aW50NjRf
dCBmbGFncyksCj4+Pj4+Pj4+PiArCVRQX0FSR1MocCwgc3RhcnQsIGVuZCwgbnB0ZXMsIGRzdCwg
aW5jciwgZmxhZ3MpLAo+Pj4+Pj4+Pj4gKwlUUF9TVFJVQ1RfX2VudHJ5KAo+Pj4+Pj4+Pj4gKwkJ
CSBfX2ZpZWxkKHU2NCwgc3RhcnQpCj4+Pj4+Pj4+PiArCQkJIF9fZmllbGQodTY0LCBlbmQpCj4+
Pj4+Pj4+PiArCQkJIF9fZmllbGQodTY0LCBmbGFncykKPj4+Pj4+Pj4+ICsJCQkgX19maWVsZCh1
bnNpZ25lZCBpbnQsIG5wdGVzKQo+Pj4+Pj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgaW5jcikKPj4+
Pj4+Pj4+ICsJCQkgX19keW5hbWljX2FycmF5KHU2NCwgZHN0LCBucHRlcykKPj4+Pj4+Pj4gQXMg
ZGlzY3Vzc2VkIHdpdGggdGhlIHRyYWNlIHN1YnN5c3RlbSBtYWludGFpbmVyIHdlIG5lZWQgdG8g
YWRkIHRoZSBwaWQKPj4+Pj4+Pj4gYW5kIHByb2JhYmx5IHRoZSBWTSBjb250ZXh0IElEIHdlIHVz
ZSBoZXJlIHRvIGlkZW50aWZ5IHRoZSB1cGRhdGVkIFZNLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBDaHJp
c3RpYW4uCj4+Pj4+Pj4gSSBwcmludGVkIGJvdGggdm0tPnRhc2tfaW5mby5waWQgVnMgY3VycmVu
dC0+cGlkIGZvciB0ZXN0aW5nLCBhbmQgSSBjYW4gc2VlIGRpZmZlcmVudCB2YWx1ZXMgY29taW5n
IG91dCBvZiAuCj4+Pj4+Pj4KPj4+Pj4+PiBnbm9tZS1zaGVsbC0yMTE0wqAgWzAxMV3CoMKgwqAg
NDEuODEyODk0OiBhbWRncHVfdm1fdXBkYXRlX3B0ZXM6IHN0YXJ0OjB4MDgwMDEwMmU4MCBlbmQ6
MHgwODAwMTAyZTgyLCBmbGFnczoweDgwLCBpbmNyOjQwOTYsIHBpZD0yMTI4IHZtaWQ9MCBjcGlk
PTIxMTQKPj4+Pj4+Pgo+Pj4+Pj4+IHBpZCBpcyB2bS0+dGFza19pbmZvLnBpZD0yMTI4IHdoZXJl
YXMgY3BpZD0yMTE0IGlzIGN1cnJlbnQucGlkLgo+Pj4+Pj4+Cj4+Pj4+Pj4gV2hpY2ggaXMgdGhl
IG9uZSB3ZSB3YW50IHRvIHNlbmQgd2l0aCB0aGUgZXZlbnQgPwo+Pj4+Pj4gVGhhdCBpcyB2bS0+
dGFza19pbmZvLnBpZCwgc2luY2UgdGhpcyBpcyB0aGUgUElEIHdoaWNoIGlzIHVzaW5nIHRoZSBW
TQo+Pj4+Pj4gZm9yIGNvbW1hbmQgc3VibWlzc2lvbi4KPj4+Pj4gZ290IGl0Lgo+Pj4+Pj4+IFRy
YWNlIGV2ZW50IGJ5IGRlZmF1bHQgc2VlbXMgdG8gYmUgYWRkaW5nIHRoZSBwcm9jZXNzIG5hbWUg
YW5kIGlkIGF0IHRoZSBoZWFkZXIgb2YgdGhlIGV2ZW50IChnbm9tZS1zaGVsbC0yMTE0KSwgd2hp
Y2ggaXMgc2FtZSBhcyBjdXJyZW50LnBpZAo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBBbHNvLCBp
cyBpdCBvayB0byBleHRyYWN0IHZtaWQgZnJvbSBqb2ItPnZtaWQgPwo+Pj4+Pj4gT25seSBpbiB0
cmFjZV9hbWRncHVfdm1fZ3JhYl9pZCgpLCBpbiBhbGwgb3RoZXIgY2FzZXMgaXQncyBwcm9iYWJs
eSBub3QKPj4+Pj4+IGFzc2lnbmVkIHlldC4KPj4+Pj4gT2ssIGxldCBtZSBjaGVjayBob3cgY2Fu
IHdlIGdldCB2bWlkIGZyb20gdGhpcyBjb250ZXh0IHdlIGFyZSBzZW5kaW5nIHRoZSBldmVudCBm
cm9tLiBPciBtYXliZSBJIHdlIHNob3VsZMKgIGtlZXAgVjUgd2l0aCBwaWQgb25seSwgYW5kIGxh
dGVyIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCB0byBhZGQgdm1pZCA/Cj4+Pj4gSSdtIG5vdCBzdXJl
IGhvdyB5b3Ugd2FudCB0byBnZXQgYSBWTUlEIGluIHRoZSBmaXJzdCBwbGFjZS4gV2UKPj4+PiBk
eW5hbWljYWxseSBhc3NpZ24gVk1JRHMgZHVyaW5nIGNvbW1hbmQgc3VibWlzc2lvbi4KPj4+Pgo+
Pj4+IFNlZSB0aGUgYW1kZ3B1X3ZtX2dyYWJfaWQgdHJhY2UgcG9pbnQuCj4+PiBBY3R1YWxseSBJ
IHdhcyBhZGRpbmcgdm1pZCB0byBhZGRyZXNzIHRoaXMgbGFzdCBjb21tZW50IG9uIFY0Ogo+Pj4+
IGFuZCBwcm9iYWJseSB0aGUgVk0gY29udGV4dCBJRCB3ZSB1c2UgaGVyZSB0byBpZGVudGlmeSB0
aGUgdXBkYXRlZCBWTS4KPj4+IEkgYXNzdW1lZCB5b3UgbWVhbnQgdGhlIHZtaWQgYnkgdGhpcywg
aXMgdGhhdCBub3Qgc28gPwo+PiBBaCEgTm8gdGhhdCdzIHNvbWV0aGluZyBjb21wbGV0ZWx5IGRp
ZmZlcmVudCA6KQo+Pgo+PiBUaGUgVk1JRCBpcyBhIDRiaXQgaGFyZHdhcmUgaWRlbnRpZmllciB1
c2VkIGZvciBUTEIgb3B0aW1pemF0aW9uLgo+Pgo+PiBUaGUgVk0gY29udGV4dCBJRCBpcyBhbiB1
bmlxdWUgNjRiaXQgbnVtYmVyLCB3ZSB1c3VhbGx5IHVzZQo+PiB2bS0+aW1tZWRpYXRlLmZlbmNl
X2NvbnRleHQgZm9yIHRoaXMuCj4gRGFtbiwgd2h5IGlzIGl0IG5ldmVyIHdoYXQgeW91IGhvcGUg
aXQgdG8gYmUgOikuIFRoYW5rcyBmb3IgdGhpcyBpbmZvcm1hdGlvbiwgSSB3aWxsIGNoZWNrIHRo
aXMgb3V0IGZpcnN0LgoKTXVsdGlwbGUgcmVhc29ucyA6KQoKT25lIGlzIHRoYXQgSSdtIG5vdCBh
IG5hdGl2ZSBzcGVha2VyIG9mIEVuZ2xpc2ggYW5kIG9ubHkgaGFkIHZlcnkgCmxpbWl0ZWQgZm9y
bWFsIGVkdWNhdGlvbiBpbiB0aGUgbGFuZ3VhZ2UgOikKCkFub3RoZXIgb25lIGlzIHRoYXQgdGhl
IGhhcmR3YXJlIGFuZCBkcml2ZXIgaXMgcmF0aGVyIGNvbXBsaWNhdGVkLgoKUmVnYXJkcywKQ2hy
aXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
