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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38799C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3C5206FA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 12:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4G8u4pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3C5206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913946E091;
	Wed, 19 Aug 2020 12:33:34 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EFD6E091
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 12:33:33 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id a14so21368466wra.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=coPAfYgJbiCPpgVvRzqz0OlutR2HLEEvFSCkYP8LpG0=;
 b=P4G8u4pGOty8rqH3Oq8o5mfQTmc1BuJZmfxilWgpXAlhCHa95sGfZB6I37y5XTmov3
 AKh059OLMyZBf53C2KJx6FRLwKMRNg6LHbk7ioTDh73Ui+tdGVcXXwdlx1Bil8ewUuiF
 pmorqOuN51cpVVhIU/q6jIl/ShgBkLJ6TWZ68aLHkHgrIFAk94qIwAf6LivP/iqUWhXw
 nBtk+itRWi/FY9g2QcHN9smiMlThRIA9Uhd9MPgUZUXtXfyN2K9khly0JOM5GXyoC4w7
 ql8NgjUo4fi/MaCdKSPoCGX96UppybFY6w4mRx/tYGuFVEumZAqv35qmzQq2lr+IxfQZ
 yORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=coPAfYgJbiCPpgVvRzqz0OlutR2HLEEvFSCkYP8LpG0=;
 b=KyDu/LuDZ9cxaxJI6cJBVHbB47e4jjS/j2jD8/5sVhgQNMZsv3Rz4S/nZHj5lr1l3U
 7OOqA3toKWPLxIfb/yBpGi9tL9cmyzySCK7JedfdvLt6Zyy+LXYyfBxlMYUXBRbayNvO
 NsQFtgncILU050O5g0TUwb4/ttvm+TKFOmDSuFqPeokV2vmt+K38PZ0UdRhoJu3nkqmg
 Bx4IWTBF3qqXgkB/AlWwkwAY7QsfccWGxNL4tlvRqFjTf9OUhp/PiwS+vQNt0r4T87PU
 UOA8XrSKxHm3WEShrD/CecXDByPJygulkc4gSw4A9A36Rqyn90z3QSCaBClzXO2dlWDG
 7ZJw==
X-Gm-Message-State: AOAM5316Tp85/Ie0FoLgxYFib/IXvU6/m7gh2SevUFQyIucywEmsbb8t
 tuQ6yTu00kRUrCe6b3L1PKsT8jRgkC0=
X-Google-Smtp-Source: ABdhPJwipl4ZkMkDrXpN1A3xcE4hINidCigTNjjLyZdgOnemryC9ih3ORzERCQs/EhsfZDCAAnB2SA==
X-Received: by 2002:adf:81c5:: with SMTP id 63mr25508195wra.185.1597840411954; 
 Wed, 19 Aug 2020 05:33:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 188sm11065449wmz.2.2020.08.19.05.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 05:33:31 -0700 (PDT)
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <42ef3112-81fb-d58b-4335-c19655f5db07@gmail.com>
Date: Wed, 19 Aug 2020 14:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3cc6b2fe-995d-581a-5e56-913a0cf60b42@amd.com>
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

QW0gMTkuMDguMjAgdW0gMTQ6MTkgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gT24gMTkvMDgv
MjAgNTozOCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTkuMDguMjAgdW0gMTM6
NTIgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+PiBPbiAxMy8wOC8yMCAxOjI4IHBtLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDEzLjA4LjIwIHVtIDA1OjA0IHNjaHJpZWIgU2hh
c2hhbmsgU2hhcm1hOgo+Pj4+PiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgdHJhY2UgZXZlbnQgdG8g
dHJhY2sgdGhlIFBURSB1cGRhdGUKPj4+Pj4gZXZlbnRzLiBUaGlzIHNwZWNpZmljIGV2ZW50IHdp
bGwgcHJvdmlkZSBpbmZvcm1hdGlvbiBsaWtlOgo+Pj4+PiAtIHN0YXJ0IGFuZCBlbmQgb2Ygdmly
dHVhbCBtZW1vcnkgbWFwcGluZwo+Pj4+PiAtIEhXIGVuZ2luZSBmbGFncyBmb3IgdGhlIG1hcAo+
Pj4+PiAtIHBoeXNpY2FsIGFkZHJlc3MgZm9yIG1hcHBpbmcKPj4+Pj4KPj4+Pj4gVGhpcyB3aWxs
IGJlIHBhcnRpY3VsYXJseSB1c2VmdWwgZm9yIG1lbW9yeSBwcm9maWxpbmcgdG9vbHMKPj4+Pj4g
KGxpa2UgUk1WKSB3aGljaCBhcmUgbW9uaXRvcmluZyB0aGUgcGFnZSB0YWJsZSB1cGRhdGUgZXZl
bnRzLgo+Pj4+Pgo+Pj4+PiBWMjogQWRkZWQgcGh5c2ljYWwgYWRkcmVzcyBsb29rdXAgbG9naWMg
aW4gdHJhY2UgcG9pbnQKPj4+Pj4gVjM6IHN3aXRjaCB0byB1c2UgX19keW5hbWljX2FycmF5Cj4+
Pj4+ICAgICAgICBhZGRlZCBucHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKPj4+
Pj4gICAgICAgIGFkZGVkIHBhZ2Ugc2l6ZSBpbiB0aGUgYXJnIGxpc3QKPj4+Pj4gVjQ6IEFkZHJl
c3NlZCBDaHJpc3RpYW4ncyByZXZpZXcgY29tbWVudHMKPj4+Pj4gICAgICAgIGFkZCBzdGFydC9l
bmQgaW5zdGVhZCBvZiBzZWcKPj4+Pj4gICAgICAgIHVzZSBpbmNyIGluc3RlYWQgb2YgcGFnZV9z
eiB0byBiZSBhY2N1cmF0ZQo+Pj4+Pgo+Pj4+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJt
YSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggfCAzNyArKysrKysrKysrKysrKysrKysr
KysrKwo+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAg
fCAgOSArKysrLS0KPj4+Pj4gICAgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3RyYWNlLmgKPj4+Pj4gaW5kZXggNjNlNzM0YTEyNWZiLi5kZjEyY2Y4NDY2YzIgMTAwNjQ0
Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4+
IEBAIC0zMjEsNiArMzIxLDQzIEBAIERFRklORV9FVkVOVChhbWRncHVfdm1fbWFwcGluZywgYW1k
Z3B1X3ZtX2JvX2NzLAo+Pj4+PiAgICAgCSAgICBUUF9BUkdTKG1hcHBpbmcpCj4+Pj4+ICAgICAp
Owo+Pj4+PiAgICAgCj4+Pj4+ICtUUkFDRV9FVkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4+
Pj4+ICsJICAgIFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKPj4+
Pj4gKwkJICAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3QgZW5kLAo+Pj4+PiArCQkgICAgIHVu
c2lnbmVkIGludCBucHRlcywgdWludDY0X3QgZHN0LAo+Pj4+PiArCQkgICAgIHVpbnQ2NF90IGlu
Y3IsIHVpbnQ2NF90IGZsYWdzKSwKPj4+Pj4gKwlUUF9BUkdTKHAsIHN0YXJ0LCBlbmQsIG5wdGVz
LCBkc3QsIGluY3IsIGZsYWdzKSwKPj4+Pj4gKwlUUF9TVFJVQ1RfX2VudHJ5KAo+Pj4+PiArCQkJ
IF9fZmllbGQodTY0LCBzdGFydCkKPj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgZW5kKQo+Pj4+PiAr
CQkJIF9fZmllbGQodTY0LCBmbGFncykKPj4+Pj4gKwkJCSBfX2ZpZWxkKHVuc2lnbmVkIGludCwg
bnB0ZXMpCj4+Pj4+ICsJCQkgX19maWVsZCh1NjQsIGluY3IpCj4+Pj4+ICsJCQkgX19keW5hbWlj
X2FycmF5KHU2NCwgZHN0LCBucHRlcykKPj4+PiBBcyBkaXNjdXNzZWQgd2l0aCB0aGUgdHJhY2Ug
c3Vic3lzdGVtIG1haW50YWluZXIgd2UgbmVlZCB0byBhZGQgdGhlIHBpZAo+Pj4+IGFuZCBwcm9i
YWJseSB0aGUgVk0gY29udGV4dCBJRCB3ZSB1c2UgaGVyZSB0byBpZGVudGlmeSB0aGUgdXBkYXRl
ZCBWTS4KPj4+Pgo+Pj4+IENocmlzdGlhbi4KPj4+IEkgcHJpbnRlZCBib3RoIHZtLT50YXNrX2lu
Zm8ucGlkIFZzIGN1cnJlbnQtPnBpZCBmb3IgdGVzdGluZywgYW5kIEkgY2FuIHNlZSBkaWZmZXJl
bnQgdmFsdWVzIGNvbWluZyBvdXQgb2YgLgo+Pj4KPj4+IGdub21lLXNoZWxsLTIxMTTCoCBbMDEx
XcKgwqDCoCA0MS44MTI4OTQ6IGFtZGdwdV92bV91cGRhdGVfcHRlczogc3RhcnQ6MHgwODAwMTAy
ZTgwIGVuZDoweDA4MDAxMDJlODIsIGZsYWdzOjB4ODAsIGluY3I6NDA5NiwgcGlkPTIxMjggdm1p
ZD0wIGNwaWQ9MjExNAo+Pj4KPj4+IHBpZCBpcyB2bS0+dGFza19pbmZvLnBpZD0yMTI4IHdoZXJl
YXMgY3BpZD0yMTE0IGlzIGN1cnJlbnQucGlkLgo+Pj4KPj4+IFdoaWNoIGlzIHRoZSBvbmUgd2Ug
d2FudCB0byBzZW5kIHdpdGggdGhlIGV2ZW50ID8KPj4gVGhhdCBpcyB2bS0+dGFza19pbmZvLnBp
ZCwgc2luY2UgdGhpcyBpcyB0aGUgUElEIHdoaWNoIGlzIHVzaW5nIHRoZSBWTQo+PiBmb3IgY29t
bWFuZCBzdWJtaXNzaW9uLgo+IGdvdCBpdC4KPj4+IFRyYWNlIGV2ZW50IGJ5IGRlZmF1bHQgc2Vl
bXMgdG8gYmUgYWRkaW5nIHRoZSBwcm9jZXNzIG5hbWUgYW5kIGlkIGF0IHRoZSBoZWFkZXIgb2Yg
dGhlIGV2ZW50IChnbm9tZS1zaGVsbC0yMTE0KSwgd2hpY2ggaXMgc2FtZSBhcyBjdXJyZW50LnBp
ZAo+Pj4KPj4+Cj4+PiBBbHNvLCBpcyBpdCBvayB0byBleHRyYWN0IHZtaWQgZnJvbSBqb2ItPnZt
aWQgPwo+PiBPbmx5IGluIHRyYWNlX2FtZGdwdV92bV9ncmFiX2lkKCksIGluIGFsbCBvdGhlciBj
YXNlcyBpdCdzIHByb2JhYmx5IG5vdAo+PiBhc3NpZ25lZCB5ZXQuCj4gT2ssIGxldCBtZSBjaGVj
ayBob3cgY2FuIHdlIGdldCB2bWlkIGZyb20gdGhpcyBjb250ZXh0IHdlIGFyZSBzZW5kaW5nIHRo
ZSBldmVudCBmcm9tLiBPciBtYXliZSBJIHdlIHNob3VsZMKgIGtlZXAgVjUgd2l0aCBwaWQgb25s
eSwgYW5kIGxhdGVyIHNlbmQgYSBzZXBhcmF0ZSBwYXRjaCB0byBhZGQgdm1pZCA/CgpJJ20gbm90
IHN1cmUgaG93IHlvdSB3YW50IHRvIGdldCBhIFZNSUQgaW4gdGhlIGZpcnN0IHBsYWNlLiBXZSAK
ZHluYW1pY2FsbHkgYXNzaWduIFZNSURzIGR1cmluZyBjb21tYW5kIHN1Ym1pc3Npb24uCgpTZWUg
dGhlIGFtZGdwdV92bV9ncmFiX2lkIHRyYWNlIHBvaW50LgoKQ2hyaXN0aWFuLgoKPgo+IC0gU2hh
c2hhbmsKPgo+PiBDaHJpc3RpYW4uCj4+Cj4+PiBSZWdhcmRzCj4+Pgo+Pj4gU2hhc2hhbmsKPj4+
Cj4+Pj4+ICsJKSwKPj4+Pj4gKwo+Pj4+PiArCVRQX2Zhc3RfYXNzaWduKAo+Pj4+PiArCQkJdW5z
aWduZWQgaW50IGk7Cj4+Pj4+ICsKPj4+Pj4gKwkJCV9fZW50cnktPnN0YXJ0ID0gc3RhcnQ7Cj4+
Pj4+ICsJCQlfX2VudHJ5LT5lbmQgPSBlbmQ7Cj4+Pj4+ICsJCQlfX2VudHJ5LT5mbGFncyA9IGZs
YWdzOwo+Pj4+PiArCQkJX19lbnRyeS0+aW5jciA9IGluY3I7Cj4+Pj4+ICsJCQlfX2VudHJ5LT5u
cHRlcyA9IG5wdGVzOwo+Pj4+PiArCQkJZm9yIChpID0gMDsgaSA8IG5wdGVzOyArK2kpIHsKPj4+
Pj4gKwkJCQl1NjQgYWRkciA9IHAtPnBhZ2VzX2FkZHIgPyBhbWRncHVfdm1fbWFwX2dhcnQoCj4+
Pj4+ICsJCQkJCXAtPnBhZ2VzX2FkZHIsIGRzdCkgOiBkc3Q7Cj4+Pj4+ICsKPj4+Pj4gKwkJCQko
KHU2NCAqKV9fZ2V0X2R5bmFtaWNfYXJyYXkoZHN0KSlbaV0gPSBhZGRyOwo+Pj4+PiArCQkJCWRz
dCArPSBpbmNyOwo+Pj4+PiArCQkJfQo+Pj4+PiArCSksCj4+Pj4+ICsJVFBfcHJpbnRrKCJzdGFy
dDoweCUwMTBsbHggZW5kOjB4JTAxMGxseCwgZmxhZ3M6MHglbGx4LCBpbmNyOiVsbHUsIgo+Pj4+
PiArCQkgICIgZHN0OlxuJXMiLCBfX2VudHJ5LT5zdGFydCwgX19lbnRyeS0+ZW5kLCBfX2VudHJ5
LT5mbGFncywKPj4+Pj4gKwkJICBfX2VudHJ5LT5pbmNyLCBfX3ByaW50X2FycmF5KAo+Pj4+PiAr
CQkgIF9fZ2V0X2R5bmFtaWNfYXJyYXkoZHN0KSwgX19lbnRyeS0+bnB0ZXMsIDgpKQo+Pj4+PiAr
KTsKPj4+Pj4gKwo+Pj4+PiAgICAgVFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX3NldF9wdGVzLAo+Pj4+
PiAgICAgCSAgICBUUF9QUk9UTyh1aW50NjRfdCBwZSwgdWludDY0X3QgYWRkciwgdW5zaWduZWQg
Y291bnQsCj4+Pj4+ICAgICAJCSAgICAgdWludDMyX3QgaW5jciwgdWludDY0X3QgZmxhZ3MsIGJv
b2wgZGlyZWN0KSwKPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+
Pj4gaW5kZXggNzFlMDA1Y2YyOTUyLi5iNWRiYjVlOGJjNjEgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+Pj4+IEBAIC0xNTEzLDE3ICsxNTEzLDIy
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBk
YXRlX3BhcmFtcyAqcGFyYW1zLAo+Pj4+PiAgICAgCQlkbyB7Cj4+Pj4+ICAgICAJCQl1aW50NjRf
dCB1cGRfZW5kID0gbWluKGVudHJ5X2VuZCwgZnJhZ19lbmQpOwo+Pj4+PiAgICAgCQkJdW5zaWdu
ZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQpID4+IHNoaWZ0Owo+Pj4+PiArCQkJdWlu
dDY0X3QgdXBkX2ZsYWdzID0gZmxhZ3MgfCBBTURHUFVfUFRFX0ZSQUcoZnJhZyk7Cj4+Pj4+ICAg
ICAKPj4+Pj4gICAgIAkJCS8qIFRoaXMgY2FuIGhhcHBlbiB3aGVuIHdlIHNldCBoaWdoZXIgbGV2
ZWwgUERzIHRvCj4+Pj4+ICAgICAJCQkgKiBzaWxlbnQgdG8gc3RvcCBmYXVsdCBmbG9vZHMuCj4+
Pj4+ICAgICAJCQkgKi8KPj4+Pj4gICAgIAkJCW5wdGVzID0gbWF4KG5wdGVzLCAxdSk7Cj4+Pj4+
ICsKPj4+Pj4gKwkJCXRyYWNlX2FtZGdwdV92bV91cGRhdGVfcHRlcyhwYXJhbXMsIGZyYWdfc3Rh
cnQsIHVwZF9lbmQsCj4+Pj4+ICsJCQkJCQkgICAgbnB0ZXMsIGRzdCwgaW5jciwKPj4+Pj4gKwkJ
CQkJCSAgICB1cGRfZmxhZ3MpOwo+Pj4+PiAgICAgCQkJYW1kZ3B1X3ZtX3VwZGF0ZV9mbGFncyhw
YXJhbXMsIHB0LCBjdXJzb3IubGV2ZWwsCj4+Pj4+ICAgICAJCQkJCSAgICAgICBwZV9zdGFydCwg
ZHN0LCBucHRlcywgaW5jciwKPj4+Pj4gLQkJCQkJICAgICAgIGZsYWdzIHwgQU1ER1BVX1BURV9G
UkFHKGZyYWcpKTsKPj4+Pj4gKwkJCQkJICAgICAgIHVwZF9mbGFncyk7Cj4+Pj4+ICAgICAKPj4+
Pj4gICAgIAkJCXBlX3N0YXJ0ICs9IG5wdGVzICogODsKPj4+Pj4gLQkJCWRzdCArPSAodWludDY0
X3QpbnB0ZXMgKiBBTURHUFVfR1BVX1BBR0VfU0laRSA8PCBzaGlmdDsKPj4+Pj4gKwkJCWRzdCAr
PSBucHRlcyAqIGluY3I7Cj4+Pj4+ICAgICAKPj4+Pj4gICAgIAkJCWZyYWdfc3RhcnQgPSB1cGRf
ZW5kOwo+Pj4+PiAgICAgCQkJaWYgKGZyYWdfc3RhcnQgPj0gZnJhZ19lbmQpIHsKPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
