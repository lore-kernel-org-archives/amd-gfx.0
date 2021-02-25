Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DECC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 13:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA9264F03
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 13:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA9264F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9EF6E17F;
	Thu, 25 Feb 2021 13:53:35 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221CC6E17F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 13:53:35 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id p1so2441118edy.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 05:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=DXRtmxwiDxxr4obS1w0N6wgFyld7u3Gly8opVfiWLpk=;
 b=JGm6SeT8Jm6mVDESTrWFq82FKbJVAwepTNPcb/vVxoN/9pPTTEqIQuAxYy/h4gi6O1
 pWDjcX7sUwNBtmwlAcDyAPHIYd7+ka5xF9HRlq9RXyn2DQFWdYChXva0CtWtXYWw4bZ8
 Ayz3KYwslN9gkHj+5o+BUUrSsmGej+2vYXVRgxQwiXmVjEEF1bvWWndrnGp8SMtBhGKx
 Jsb28H0baIpHu6jhURvOmDHjT0fpd/IoVKRrxLZ9f25s50APrUyGdCHxR7gCe++Anj4S
 JuVZCkqv8yy8OK4wOUSg5TABvE7QmQmTrJj13nRrdXvmmBLiFSTtMg0THwqIKbxGDt+n
 bkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DXRtmxwiDxxr4obS1w0N6wgFyld7u3Gly8opVfiWLpk=;
 b=Z9Ned1P7v80XmNj4Ep4DorFlxOPvxzhtmYyA9Fme0wZyfBnplbL+sZN7tMeds5n4Iw
 snTJfv8ZXedzsdCaJzS3oeCYH1YnKNJug/s3YO/z4XQO/ZjRKw8WXkQ+sAn3/lUpsjtc
 3gike26FtNgI81jwKlPx7jXapXzQvtT5eI16YRNja8ODBCwKJzl8rNNTD2iCXz23KutK
 5UxaKZEUHopHmZWNPLmPdYm5pPhaFeNosf9ioVzmgCGMxMnnv6mAQZvBQI8YnLi0uXa1
 glVYP5lOiTdW5dQpn3zvvhNfZSotUF3jJv44upW2EKmInizS2sF+gMK7ofdljdkEjFwU
 vVKg==
X-Gm-Message-State: AOAM530xjv4AcT2RdYC7Fen1NQvdEoPB1O9+iUK2Jg+964rt4dbP+A6m
 +1fw3kl1l9dj3RzCZFD1NuhjFQvytNKbLg==
X-Google-Smtp-Source: ABdhPJy6Zkr9+YBKgcri+1eseOjyUdXMEswk57Pu8URWzS2ZCj8SW7cBPXdZHhaH2BuYlzVX6JSDLQ==
X-Received: by 2002:a50:fe89:: with SMTP id d9mr3049347edt.57.1614261213803;
 Thu, 25 Feb 2021 05:53:33 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:fc8:43:f4c0:95af?
 ([2a02:908:1252:fb60:fc8:43:f4c0:95af])
 by smtp.gmail.com with ESMTPSA id d5sm3564961edu.12.2021.02.25.05.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Feb 2021 05:53:33 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add ih call to process until checkpoint
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210223211026.116403-1-jonathan.kim@amd.com>
 <6d30f52e-7a7a-5662-a66f-db832b8386ae@amd.com>
 <DM5PR12MB4680F60D6590680E40A90AF5859F9@DM5PR12MB4680.namprd12.prod.outlook.com>
 <92ddf2b3-3ee7-d481-2794-b57daed40ef9@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8650a46f-f40d-d627-42a5-d9d760400086@gmail.com>
Date: Thu, 25 Feb 2021 14:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <92ddf2b3-3ee7-d481-2794-b57daed40ef9@amd.com>
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAyNS4wMi4yMSB1bSAwNDoxNSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IE9uIDIwMjEt
MDItMjQgMTA6NTQgYS5tLiwgS2ltLCBKb25hdGhhbiB3cm90ZToKPj4gW0FNRCBPZmZpY2lhbCBV
c2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+Pgo+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPj4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+Cj4+PiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI0LCAyMDIxIDQ6MTcg
QU0KPj4+IFRvOiBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47IGFtZC0KPj4+
IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IENjOiBZYW5nLCBQaGlsaXAgPFBoaWxpcC5Z
YW5nQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXgKPj4+IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pgo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIGloIGNhbGwgdG8gcHJv
Y2VzcyB1bnRpbCAKPj4+IGNoZWNrcG9pbnQKPj4+Cj4+PiBBbSAyMy4wMi4yMSB1bSAyMjoxMCBz
Y2hyaWViIEpvbmF0aGFuIEtpbToKPj4+PiBBZGQgSUggZnVuY3Rpb24gdG8gYWxsb3cgY2FsbGVy
IHRvIHByb2Nlc3MgcmluZyBlbnRyaWVzIHVudGlsIHRoZQo+Pj4+IGNoZWNrcG9pbnQgd3JpdGUg
cG9pbnRlci4KPj4+IFRoaXMgbmVlZHMgYSBiZXR0ZXIgZGVzY3JpcHRpb24gb2Ygd2hhdCB0aGlz
IHdpbGwgYmUgdXNlZCBmb3IuCj4+IEZlbGl4IG9yIFBoaWxpcCBjb3VsZCBlbGFib3JhdGUgYmV0
dGVyIGZvciBITU0gbmVlZHMuCj4+IERlYnVnZ2luZyB0b29scyByZXF1aXJlcyB0aGlzIGJ1dCBp
dCdzIGluIGV4cGVyaW1lbnRhbCBtb2RlIGF0IHRoZSAKPj4gbW9tZW50IHNvIHByb2JhYmx5IG5v
dCB0aGUgYmVzdCBwbGFjZSB0byBkZXNjcmliZSBoZXJlLgo+Cj4gT24gdGhlIEhNTSBzaWRlIHdl
J3JlIHBsYW5uaW5nIHRvIHVzZSB0aGlzIHRvIGRyYWluIHBlbmRpbmcgcGFnZSBmYXVsdCAKPiBp
bnRlcnJ1cHRzIGJlZm9yZSB3ZSB1bm1hcCBtZW1vcnkuIFRoYXQgc2hvdWxkIGFkZHJlc3MgcGhh
bnRvbSBWTSAKPiBmYXVsdHMgYWZ0ZXIgbWVtb3J5IGlzIHVubWFwcGVkLgoKVGhvdWdodCBzby4g
SSBzdWdnZXN0IHRvIHVzZSBhIHdhaXRfZXZlbnQoKSBoZXJlIHdoaWNoIG9uIHRoZSB3YWl0ZXIg
CnNpZGUgY2hlY2tzIGloLT5sb2NrIGFuZCBhZGQgYSB3YWtlX3VwX2FsbCgpIGF0IHRoZSBlbmQg
b2YgCmFtZGdwdV9paF9wcm9jZXNzLiBJIHdvbid0IHRvdWNoIHJwdHIgb3Igd3B0ciBhdCBhbGwg
Zm9yIHRoaXMuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiDCoCBGZWxpeAo+
Cj4KPj4KPj4+PiBTdWdnZXN0ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0Bh
bWQuY29tPgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFt
ZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaWguYyB8IDQ2Cj4+PiArKysrKysrKysrKysrKysrKysrKysrKysrLQo+Pj4+IGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oIHzCoCAyICsrCj4+Pj4gwqDCoCAyIGZpbGVz
IGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pgo+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYwo+Pj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMKPj4+PiBpbmRleCBkYzg1MmFmNGYz
YjcuLmNhZTUwYWY5NTU5ZCAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaWguYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9paC5jCj4+Pj4gQEAgLTIyLDcgKzIyLDcgQEAKPj4+PiDCoMKgwqAgKi8KPj4+Pgo+Pj4+
IMKgwqAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+Cj4+Pj4gLQo+Pj4+ICsjaW5jbHVk
ZSA8bGludXgvcHJvY2Vzc29yLmg+Cj4+Pj4gwqDCoCAjaW5jbHVkZSAiYW1kZ3B1LmgiCj4+Pj4g
wqDCoCAjaW5jbHVkZSAiYW1kZ3B1X2loLmgiCj4+Pj4KPj4+PiBAQCAtMTYwLDYgKzE2MCw1MCBA
QCB2b2lkIGFtZGdwdV9paF9yaW5nX3dyaXRlKHN0cnVjdAo+Pj4gYW1kZ3B1X2loX3JpbmcgKmlo
LCBjb25zdCB1aW50MzJfdCAqaXYsCj4+Pj4gwqDCoCB9Cj4+Pj4gwqDCoCB9Cj4+Pj4KPj4+PiAr
LyoqCj4+Pj4gKyAqIGFtZGdwdV9paF93YWl0X29uX2NoZWNrcG9pbnRfcHJvY2VzcyAtIHdhaXQg
dG8gcHJvY2VzcyBJVnMgdXAgdG8KPj4+PiArY2hlY2twb2ludAo+Pj4+ICsgKgo+Pj4+ICsgKiBA
YWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4+Pj4gKyAqIEBpaDogaWggcmluZyB0byBwcm9j
ZXNzCj4+Pj4gKyAqCj4+Pj4gKyAqIFVzZWQgdG8gZW5zdXJlIHJpbmcgaGFzIHByb2Nlc3NlZCBJ
VnMgdXAgdG8gdGhlIGNoZWNrcG9pbnQgd3JpdGUKPj4+IHBvaW50ZXIuCj4+Pj4gKyAqLwo+Pj4+
ICtpbnQgYW1kZ3B1X2loX3dhaXRfb25fY2hlY2twb2ludF9wcm9jZXNzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlCj4+PiAqYWRldiwKPj4+PiArc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCkKPj4+PiAr
ewo+Pj4+ICt1MzIgcHJldl9ycHRyLCBjdXJfcnB0ciwgY2hlY2twb2ludF93cHRyOwo+Pj4+ICsK
Pj4+PiAraWYgKCFpaC0+ZW5hYmxlZCB8fCBhZGV2LT5zaHV0ZG93bikKPj4+PiArcmV0dXJuIC1F
Tk9ERVY7Cj4+Pj4gKwo+Pj4+ICtjdXJfcnB0ciA9IFJFQURfT05DRShpaC0+cnB0cik7Cj4+Pj4g
Ky8qIE9yZGVyIHJlYWQgb2YgY3VycmVudCBycHRyIHdpdGggY2hlY2t0cG9pbnQgd3B0ci4gKi8K
Pj4+PiArbWIoKTsKPj4+PiArY2hlY2twb2ludF93cHRyID0gYW1kZ3B1X2loX2dldF93cHRyKGFk
ZXYsIGloKTsKPj4+PiArCj4+Pj4gKy8qIGFsbG93IHJwdHIgdG8gd3JhcCBhcm91bmTCoCAqLwo+
Pj4+ICtpZiAoY3VyX3JwdHIgPiBjaGVja3BvaW50X3dwdHIpIHsKPj4+PiArc3Bpbl9iZWdpbigp
Owo+Pj4+ICtkbyB7Cj4+Pj4gK3NwaW5fY3B1X3JlbGF4KCk7Cj4+Pj4gK3ByZXZfcnB0ciA9IGN1
cl9ycHRyOwo+Pj4+ICtjdXJfcnB0ciA9IFJFQURfT05DRShpaC0+cnB0cik7Cj4+Pj4gK30gd2hp
bGUgKGN1cl9ycHRyID49IHByZXZfcnB0cik7Cj4+Pj4gK3NwaW5fZW5kKCk7Cj4+PiBUaGF0J3Mg
YSBjZXJ0YWluIE5BSyBzaW5jZSBpdCBidXN5IHdhaXRzIGZvciBJSCBwcm9jZXNzaW5nLiBXZSBu
ZWVkIAo+Pj4gc29tZQo+Pj4gZXZlbnQgdG8gdHJpZ2dlciBoZXJlLgo+PiBUaGUgZnVuY3Rpb24g
aXMgbWVhbnQgdG8gYmUganVzdCBhIHdhaXRlciB1cCB0byB0aGUgY2hlY2twb2ludC4KPj4gVGhl
cmUncyBhIG5lZWQgdG8gZ3VhcmFudGVlIHRoYXQgInN0YWxlIiBpbnRlcnJ1cHRzIGhhdmUgYmVl
biAKPj4gcHJvY2Vzc2VkIG9uIGNoZWNrIGJlZm9yZSBkb2luZyBvdGhlciBzdHVmZiBhZnRlciBj
YWxsLgo+PiBUaGUgZGVzY3JpcHRpb24gY291bGQgYmUgaW1wcm92ZWQgdG8gY2xhcmlmeSB0aGF0
Lgo+Pgo+PiBXb3VsZCBidXN5IHdhaXRpbmcgb25seSBvbiBhIGxvY2tlZCByaW5nIGhlbHA/wqAg
SSBhc3N1bWUgYW4gdW5sb2NrZWQgCj4+IHJpbmcgbWVhbnMgbm90aGluZyB0byBwcm9jZXNzIHNv
IG5vIG5lZWQgdG8gd2FpdCBhbmQgd2UgY2FuIGV4aXQgCj4+IGVhcmx5LsKgIE9yIGlzIGl0IGJl
dHRlciB0byBqdXN0IHRvIHByb2Nlc3MgdGhlIGVudHJpZXMgdXAgdG8gdGhlIAo+PiBjaGVja3Bv
aW50IChtYXliZSBhZGp1c3QgYW1kZ3B1X2loX3Byb2Nlc3MgZm9yIHRoaXMgbmVlZCBsaWtlIGFk
ZGluZyAKPj4gYSBib29sIGFyZyB0byBza2lwIHJlc3RhcnQgb3Igc29tZXRoaW5nKT8KPj4KPj4g
VGhhbmtzLAo+Pgo+PiBKb24KPj4KPj4+PiArfQo+Pj4+ICsKPj4+PiArLyogd2FpdCBmb3IgcnB0
ciB0byBjYXRjaCB1cCB0byBvciBwYXNzIGNoZWNrcG9pbnQuICovCj4+Pj4gK3NwaW5fYmVnaW4o
KTsKPj4+PiArZG8gewo+Pj4+ICtzcGluX2NwdV9yZWxheCgpOwo+Pj4+ICtwcmV2X3JwdHIgPSBj
dXJfcnB0cjsKPj4+PiArY3VyX3JwdHIgPSBSRUFEX09OQ0UoaWgtPnJwdHIpOwo+Pj4+ICt9IHdo
aWxlIChjdXJfcnB0ciA+PSBwcmV2X3JwdHIgJiYgY3VyX3JwdHIgPCBjaGVja3BvaW50X3dwdHIp
Owo+Pj4gU2FtZSBvZiBjb3Vyc2UgaGVyZS4KPj4+Cj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+ICtz
cGluX2VuZCgpOwo+Pj4+ICsKPj4+PiArcmV0dXJuIDA7Cj4+Pj4gK30KPj4+PiArCj4+Pj4gwqDC
oCAvKioKPj4+PiDCoMKgwqAgKiBhbWRncHVfaWhfcHJvY2VzcyAtIGludGVycnVwdCBoYW5kbGVy
Cj4+Pj4gwqDCoMKgICoKPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2loLmgKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
aC5oCj4+Pj4gaW5kZXggNmVkNGE4NWZjN2MzLi42ODE3ZjBhODEyZDIgMTAwNjQ0Cj4+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgKPj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaAo+Pj4+IEBAIC04Nyw2ICs4Nyw4IEBA
IGludCBhbWRncHVfaWhfcmluZ19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4g
c3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwKPj4+PiDCoMKgIHZvaWQgYW1kZ3B1X2loX3Jpbmdf
ZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0Cj4+PiBhbWRncHVfaWhfcmlu
ZyAqaWgpOwo+Pj4+IMKgwqAgdm9pZCBhbWRncHVfaWhfcmluZ193cml0ZShzdHJ1Y3QgYW1kZ3B1
X2loX3JpbmcgKmloLCBjb25zdCAKPj4+PiB1aW50MzJfdCAqaXYsCj4+Pj4gwqDCoMKgwqAgdW5z
aWduZWQgaW50IG51bV9kdyk7Cj4+Pj4gK2ludCBhbWRncHVfaWhfd2FpdF9vbl9jaGVja3BvaW50
X3Byb2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UKPj4+ICphZGV2LAo+Pj4+ICtzdHJ1Y3QgYW1k
Z3B1X2loX3JpbmcgKmloKTsKPj4+PiDCoMKgIGludCBhbWRncHVfaWhfcHJvY2VzcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0Cj4+PiBhbWRncHVfaWhfcmluZyAqaWgpOwo+Pj4+
IMKgwqAgdm9pZCBhbWRncHVfaWhfZGVjb2RlX2l2X2hlbHBlcihzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKPj4+PiDCoMKgIHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgsCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
