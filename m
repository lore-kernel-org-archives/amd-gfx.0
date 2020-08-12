Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FABC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA252065C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhYjn6HT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA252065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E823A6E0D9;
	Wed, 12 Aug 2020 12:46:26 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CA16E0D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 12:46:25 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id bo3so2079771ejb.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xbsK7204pdlS3QPKTeWZgGk7xamPY82b++XnENYIRvw=;
 b=jhYjn6HTVLNr5wbgxgiGauZJkdW2M16zv3K2EbWL5BUBGfrsQ0aH7kk9u7+G/ZgeSC
 iI/st7JRRj1paOt3QKb1Fs+X6tmjOYwBABMshdqnc6IIU0k3Z/RngkA78EqY1wTnBQ6X
 TL38DV90vBsSZJ+pVeSK1oJOrutKad8WYrqJI4OSHqpOn9vwIs1TLVzMPa/KHwfM54tW
 xub4YFEswYuualuBayLLjxY3asl8Xy86ngok9gwX9d6Er0bu7p68a5Hy5F6lYfFzjgz7
 8nlGWBSQM+dH7qs4W2ZBVZKhE0nfdMS7vmCgaIzePtC6F1RyGw9xr6CfS2+SKjuyoTaR
 dORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=xbsK7204pdlS3QPKTeWZgGk7xamPY82b++XnENYIRvw=;
 b=i1z0MngDik1lhSD2MOp7hmCdq9qvAB3OWAubi2FE/vyGgkQxcwBo6ASF1B6HLOYUJX
 BTrdBtMDkx4TTkAsraLeWnSNO/1ozh8u9RZUmKzwQkUxk3JqrW3TfFkgOgZtYZlqx7DS
 VHFdWhVn5Cj7nArQxVd6Af5dNx2NMKVfqsWr6ZgyDb8EeFk0bN0n4LlpiSskYmcOlXHq
 LSiZyw+0rU2FEacQd7wafTCoHCNbE3IMO3FH1O/j4g5cn99+tgd6F3wZtR9WjKsvaZw7
 jvYLtkhUXAZ1UbMIC4yKtITJxAxM5EtD0zgU1uFt0qxiRLm0cGQknyY9GT48x0DWgHAQ
 W+Dg==
X-Gm-Message-State: AOAM533+K27Fs3ek+amR2ByZhOTvHl91aIdP69WC70QiCzlXxlgPAOCl
 o2ahC2iocazBn8vjzpwPUBw=
X-Google-Smtp-Source: ABdhPJzQyd20inv0sjsqthTRN+l5nbG2+y8yyzGl0HYk9HKRM1X++v33Wl1ggd5g+rkvjLyi41qkjg==
X-Received: by 2002:a17:906:c29a:: with SMTP id
 r26mr30561313ejz.153.1597236384441; 
 Wed, 12 Aug 2020 05:46:24 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t3sm1403858edq.26.2020.08.12.05.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 05:46:22 -0700 (PDT)
Subject: Re: [PATCH v3] drm/amdgpu: add new trace event for page table update
 v3
To: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200812043336.127057-1-shashank.sharma@amd.com>
 <e32e6e5c-d808-44eb-7136-9b258c0201c1@gmail.com>
 <43f137f7-90cd-bb8b-f27f-a80a6c18aedc@amd.com>
 <be160250-b879-3478-2788-fee82dd60d53@amd.com>
 <6579415d-5a4f-e5b4-2142-e38931d71c7f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <36e3c9b7-e0a3-4bfc-27ce-be1c82f0eab0@gmail.com>
Date: Wed, 12 Aug 2020 14:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6579415d-5a4f-e5b4-2142-e38931d71c7f@amd.com>
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

QW0gMTIuMDguMjAgdW0gMTQ6MDkgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gT24gMTIvMDgv
MjAgMjowMiBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTIuMDguMjAgdW0gMTA6
MTUgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+PiBIZWxsbyBDaHJpc3RpYW4sCj4+Pgo+Pj4g
T24gMTIvMDgvMjAgMTI6MTUgcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMTIu
MDguMjAgdW0gMDY6MzMgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+Pj4+IFRoaXMgcGF0Y2gg
YWRkcyBhIG5ldyB0cmFjZSBldmVudCB0byB0cmFjayB0aGUgUFRFIHVwZGF0ZQo+Pj4+PiBldmVu
dHMuIFRoaXMgc3BlY2lmaWMgZXZlbnQgd2lsbCBwcm92aWRlIGluZm9ybWF0aW9uIGxpa2U6Cj4+
Pj4+IC0gc3RhcnQgYW5kIGVuZCBvZiB2aXJ0dWFsIG1lbW9yeSBtYXBwaW5nCj4+Pj4+IC0gSFcg
ZW5naW5lIGZsYWdzIGZvciB0aGUgbWFwCj4+Pj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFw
cGluZwo+Pj4+Pgo+Pj4+PiBUaGlzIHdpbGwgYmUgcGFydGljdWxhcmx5IHVzZWZ1bCBmb3IgbWVt
b3J5IHByb2ZpbGluZyB0b29scwo+Pj4+PiAobGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5n
IHRoZSBwYWdlIHRhYmxlIHVwZGF0ZSBldmVudHMuCj4+Pj4+Cj4+Pj4+IFYyOiBBZGRlZCBwaHlz
aWNhbCBhZGRyZXNzIGxvb2t1cCBsb2dpYyBpbiB0cmFjZSBwb2ludAo+Pj4+PiBWMzogc3dpdGNo
IHRvIHVzZSBfX2R5bmFtaWNfYXJyYXkKPj4+Pj4gICAgICAgIGFkZGVkIG5wdGVzIGludCB0aGUg
VFBwcmludCBhcmd1bWVudHMgbGlzdAo+Pj4+PiAgICAgICAgYWRkZWQgcGFnZSBzaXplIGluIHRo
ZSBhcmcgbGlzdAo+Pj4+Pgo+Pj4+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+Pj4+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8c2hh
c2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggfCAzOCArKysrKysrKysrKysrKysrKysrKysrKwo+
Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgfCAgOSAr
KysrLS0KPj4+Pj4gICAgIDIgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Ry
YWNlLmgKPj4+Pj4gaW5kZXggNjNlNzM0YTEyNWZiLi5iOWFhZTc5ODNiNGIgMTAwNjQ0Cj4+Pj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4+IEBAIC0z
MjEsNiArMzIxLDQ0IEBAIERFRklORV9FVkVOVChhbWRncHVfdm1fbWFwcGluZywgYW1kZ3B1X3Zt
X2JvX2NzLAo+Pj4+PiAgICAgCSAgICBUUF9BUkdTKG1hcHBpbmcpCj4+Pj4+ICAgICApOwo+Pj4+
PiAgICAgCj4+Pj4+ICtUUkFDRV9FVkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4+Pj4+ICsJ
ICAgIFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKPj4+Pj4gKwkJ
ICAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3QgZW5kLAo+Pj4+PiArCQkgICAgIHVuc2lnbmVk
IGludCBucHRlcywgdWludDY0X3QgZHN0LAo+Pj4+PiArCQkgICAgIHVpbnQ2NF90IGluY3IsIHVp
bnQ2NF90IGZsYWdzKSwKPj4+Pj4gKwlUUF9BUkdTKHAsIHN0YXJ0LCBlbmQsIG5wdGVzLCBkc3Qs
IGluY3IsIGZsYWdzKSwKPj4+Pj4gKwlUUF9TVFJVQ1RfX2VudHJ5KAo+Pj4+PiArCQkJIF9fZmll
bGQodTY0LCBzdGFydCkKPj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgZW5kKQo+Pj4+PiArCQkJIF9f
ZmllbGQodTY0LCBmbGFncykKPj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgaW5jcikKPj4+Pj4gKwkJ
CSBfX2ZpZWxkKHVuc2lnbmVkIGludCwgbnB0ZXMpCj4+Pj4+ICsJCQkgX19keW5hbWljX2FycmF5
KHU2NCwgZHN0LCBucHRlcykKPj4+Pj4gKwkpLAo+Pj4+PiArCj4+Pj4+ICsJVFBfZmFzdF9hc3Np
Z24oCj4+Pj4+ICsJCQl1bnNpZ25lZCBpbnQgaTsKPj4+Pj4gKwo+Pj4+PiArCQkJX19lbnRyeS0+
c3RhcnQgPSBzdGFydDsKPj4+Pj4gKwkJCV9fZW50cnktPmVuZCA9IGVuZDsKPj4+Pj4gKwkJCV9f
ZW50cnktPmZsYWdzID0gZmxhZ3M7Cj4+Pj4+ICsJCQlfX2VudHJ5LT5pbmNyID0gaW5jcjsKPj4+
Pj4gKwkJCV9fZW50cnktPm5wdGVzID0gbnB0ZXM7Cj4+Pj4+ICsKPj4+Pj4gKwkJCWZvciAoaSA9
IDA7IGkgPCBucHRlczsgKytpKSB7Cj4+Pj4+ICsJCQkJdTY0IGFkZHIgPSBwLT5wYWdlc19hZGRy
ID8gYW1kZ3B1X3ZtX21hcF9nYXJ0KAo+Pj4+PiArCQkJCQlwLT5wYWdlc19hZGRyLCBkc3QpIDog
ZHN0Owo+Pj4+PiArCj4+Pj4+ICsJCQkJKCh1NjQgKilfX2dldF9keW5hbWljX2FycmF5KGRzdCkp
W2ldID0gYWRkcjsKPj4+Pj4gKwkJCQlkc3QgKz0gaW5jcjsKPj4+Pj4gKwkJCX0KPj4+Pj4gKwkp
LAo+Pj4+PiArCVRQX3ByaW50aygic2VnOjB4JTAxMGxseC0weCUwMTBsbHgsIGZsYWdzOjB4JWxs
eCwgbnB0cj0ldSwgcGdzejolbGx1LCIKPj4+Pj4gKwkJICAiIGRzdDpcbiVzIiwgX19lbnRyeS0+
c3RhcnQsIF9fZW50cnktPmVuZCwgX19lbnRyeS0+ZmxhZ3MsCj4+Pj4+ICsJCSAgX19lbnRyeS0+
bnB0ZXMsIF9fZW50cnktPmluY3IsCj4+Pj4gVGhpcyBpcyBub3QgY29ycmVjdC4gVGhlIGluY3Jl
bWVudCBpcyBOT1QgdGhlIHBhZ2Ugc2l6ZSwgYnV0IHJhdGhlciB0aGUKPj4+PiBwYWdlIHNpemUg
cm91bmRlZCBkb3duIHRvIGEgcG93ZXIgb2YgNTEyKzRLLgo+Pj4+Cj4+Pj4gSW4gb3RoZXIgd29y
ZHMgcGFnZSBzaXplIGNhbiBiZSA0SywgOEssIDE2SywgMzJLLCA2NEsuLi4uMU0sIDJNLAo+Pj4+
IDRNLi4uLjUxMk0sIDFHLCAyRy4uLi4KPj4+Pgo+Pj4+IEJ1dCB0aGUgaW5jcmVtZW50IGNhbiBv
bmx5IGJlIDRLLCAyTSwgMUcuLi4uCj4+PiBVbmRlcnN0b29kLiBCdXQgSSB0aGluayB0aGUgcmVx
dWlyZW1lbnQgaGVyZSBpcyBmb3IgaW5jcmVtZW50LiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQg
dGhlIHRvb2wgbmVlZHMgdG8gc2F2ZSB0aGUgcGFnZSBlbnRyaWVzLCBhbmQgZm9yIHRoYXQsIGl0
IHdpbGwgbmVlZCBzdGFydCBvZiB2aXJ0dWFsIG1lbSwgc3RhcnQgb2YgcGh5c2ljYWwgbWVtLCBt
YXBwaW5nIHNpemUgYW5kIHN0ZXAgdG8gaW5jcmVtZW50IHRoZSBlbnRyaWVzLiBJZiB0aGF0J3Mg
c28sIHdlIGNhbiByZS1sYWJlbCB0aGlzIGVudHJ5IGFzICJzdGVwIiBpbnN0ZWFkIG9mICJwYWdl
IHNpemUiLiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IHRoaW5rIGl0J3MgdGhlIHJpZ2h0IHRo
aW5nIHRvIGRvLgo+PiBXZSBjb3VsZCBzdGljayB3aXRoIHRoZSBuYW1pbmcgaW5jcmVtZW50IGlm
IHRoYXQgaGVscHMsIGJ1dCB0aGlzIGNhbgo+PiBhbHNvIGJlIGRlcml2ZWQgZnJvbSB0aGUgbnVt
YmVyIG9mIGRlc3RpbmF0aW9uIGFkZHJlc3NlcyB3ZSBoYXZlLgo+IHN1cmUsIGkgd2lsbCBtYWtl
IGl0IGluY3JlbWVudC4KPj4gT24gdGhlIG90aGVyIGhhbmQgZXhwbGljaXRseSBtZW50aW9uaW5n
IGl0IHByb2JhYmx5IHdvbid0IGh1cnQgdXMgZWl0aGVyLgo+Pgo+PiBBbmQgYnkgdGhlIHdheSB3
aGF0IGRvZXMgInNlZyIgbWVhbj8KPiBBaCwgdG8gZ2V0IGludG8gODAgY2hhciBsaW1pdCwgSSBt
YWRlICdzZWdtZW50JyBhcyAnc2VnJyBhbmQgbGF0ZXIganVzdCByZWFsaXplZCBJIGhhdmUgdG8g
c3RpbGwgYnJlYWsgdGhlIHByaW50IGludG8gdHdvIGxpbmVzIDopIC4gSSB3aWxsIG1ha2UgaXQg
YmFjayB0byBzZWdtZW50IG9yIHN0YXJ0L2VuZAoKQWgsIG1heWJlIHJhdGhlciB1c2UgVkEgZm9y
IHZpcnR1YWwgYWRkcmVzcy4gQnV0IHN0YXJ0L2VuZCBpcyBwcm9iYWJseSAKdGhlIGJlc3Qgb3B0
aW9uLgoKQ2hyaXN0aWFuLgoKPgo+IC0gU2hhc2hhbmsKPgo+PiBDaHJpc3RpYW4uCj4+Cj4+Pj4g
QW5kIGRvIHdlIG5lZWQgdGhlIG5wdGVzIGhlcmU/IFdlIGp1c3QgbmVlZCBpdCB0byBwcmludCB0
aGUgY29ycmVjdAo+Pj4+IG51bWJlciBvZiBkZXN0aW5hdGlvbiBhZGRyZXNzZXMuCj4+PiBBZ3Jl
ZSwgd2UgZG9uJ3QgcmVhbGx5IG5lZWQgbnB0ZXMgaGVyZSwgSSB3aWxsIHJlbW92ZSB0aGF0IGFu
ZCBzZW5kIFY0Lgo+Pj4KPj4+IC0gU2hhc2hhbmsKPj4+Cj4+Pj4gUmVnYXJkcywKPj4+PiBDaHJp
c3RpYW4uCj4+Pj4KPj4+Pj4gKwkJICBfX3ByaW50X2FycmF5KF9fZ2V0X2R5bmFtaWNfYXJyYXko
ZHN0KSwgX19lbnRyeS0+bnB0ZXMsIDgpKQo+Pj4+PiArKTsKPj4+Pj4gKwo+Pj4+PiAgICAgVFJB
Q0VfRVZFTlQoYW1kZ3B1X3ZtX3NldF9wdGVzLAo+Pj4+PiAgICAgCSAgICBUUF9QUk9UTyh1aW50
NjRfdCBwZSwgdWludDY0X3QgYWRkciwgdW5zaWduZWQgY291bnQsCj4+Pj4+ICAgICAJCSAgICAg
dWludDMyX3QgaW5jciwgdWludDY0X3QgZmxhZ3MsIGJvb2wgZGlyZWN0KSwKPj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+Pj4gaW5kZXggNzFlMDA1Y2YyOTUyLi5i
NWRiYjVlOGJjNjEgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jCj4+Pj4+IEBAIC0xNTEzLDE3ICsxNTEzLDIyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zt
X3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+Pj4+
PiAgICAgCQlkbyB7Cj4+Pj4+ICAgICAJCQl1aW50NjRfdCB1cGRfZW5kID0gbWluKGVudHJ5X2Vu
ZCwgZnJhZ19lbmQpOwo+Pj4+PiAgICAgCQkJdW5zaWduZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZy
YWdfc3RhcnQpID4+IHNoaWZ0Owo+Pj4+PiArCQkJdWludDY0X3QgdXBkX2ZsYWdzID0gZmxhZ3Mg
fCBBTURHUFVfUFRFX0ZSQUcoZnJhZyk7Cj4+Pj4+ICAgICAKPj4+Pj4gICAgIAkJCS8qIFRoaXMg
Y2FuIGhhcHBlbiB3aGVuIHdlIHNldCBoaWdoZXIgbGV2ZWwgUERzIHRvCj4+Pj4+ICAgICAJCQkg
KiBzaWxlbnQgdG8gc3RvcCBmYXVsdCBmbG9vZHMuCj4+Pj4+ICAgICAJCQkgKi8KPj4+Pj4gICAg
IAkJCW5wdGVzID0gbWF4KG5wdGVzLCAxdSk7Cj4+Pj4+ICsKPj4+Pj4gKwkJCXRyYWNlX2FtZGdw
dV92bV91cGRhdGVfcHRlcyhwYXJhbXMsIGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4+Pj4+ICsJCQkJ
CQkgICAgbnB0ZXMsIGRzdCwgaW5jciwKPj4+Pj4gKwkJCQkJCSAgICB1cGRfZmxhZ3MpOwo+Pj4+
PiAgICAgCQkJYW1kZ3B1X3ZtX3VwZGF0ZV9mbGFncyhwYXJhbXMsIHB0LCBjdXJzb3IubGV2ZWws
Cj4+Pj4+ICAgICAJCQkJCSAgICAgICBwZV9zdGFydCwgZHN0LCBucHRlcywgaW5jciwKPj4+Pj4g
LQkJCQkJICAgICAgIGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpKTsKPj4+Pj4gKwkJCQkJ
ICAgICAgIHVwZF9mbGFncyk7Cj4+Pj4+ICAgICAKPj4+Pj4gICAgIAkJCXBlX3N0YXJ0ICs9IG5w
dGVzICogODsKPj4+Pj4gLQkJCWRzdCArPSAodWludDY0X3QpbnB0ZXMgKiBBTURHUFVfR1BVX1BB
R0VfU0laRSA8PCBzaGlmdDsKPj4+Pj4gKwkJCWRzdCArPSBucHRlcyAqIGluY3I7Cj4+Pj4+ICAg
ICAKPj4+Pj4gICAgIAkJCWZyYWdfc3RhcnQgPSB1cGRfZW5kOwo+Pj4+PiAgICAgCQkJaWYgKGZy
YWdfc3RhcnQgPj0gZnJhZ19lbmQpIHsKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
