Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F158C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 16:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A87619C2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 16:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A87619C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8649489F6E;
	Tue, 30 Mar 2021 16:08:25 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB9F89F6E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 16:08:24 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id x207so17005600oif.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=v1jUxjj5V5n03eDiw5YB0C8hg71h+NdCNCSZT32d57I=;
 b=hATVEsRNliJzan/+n74Hg/XJxJOx760se7c62/KF9lNha4XKOQuIrLTXJSKDQuAxlQ
 ZouHlB5mgfl8NtpgRIRvlINSS81M6NjnxEaN5iKkJyK08eGu2SVqBoz/WN/gO3/pnx7v
 wOSllCAj1G5kR1wKiIy2l84D3N9Xjm93VFdsiupnp9ANosCNmjBQnKMZEpvGQOxTXou1
 gTs0H+jrbzm3hxLjhOOtHu32vHUDIGB5uoPrTucwptMFkmkIAPyQYkFnlIZtoCSI6IAx
 0ehsDziHciCD4gM/wACU7nXoXEz+izLdnMKNkk882ayaxE99BNfLuK9XWLj01NmcG5po
 WnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=v1jUxjj5V5n03eDiw5YB0C8hg71h+NdCNCSZT32d57I=;
 b=tajFRMpYWJHqZcnC1YQxdBSm8zCLSxwwfRKnpSKCVXOvluMbKwlFrF9dtm78twgU/Z
 h5jWAAOk3F2ccVMH5xCV9gerUMvCRo2PBTQAWqWFohk8ngpP4kz1vYNyl4y14SfR3U89
 VDDtvHaaHIRRn/w+m8A1zcY6C+H0bPNaf/lWlQaVuHYS0vgVg7Wiuu89fB+M6ewSWGvN
 INn19awTfPxwH06CuXYSr0xPDSG0lmAzqXuia9XUh0pCkdj2yxgEgkPWMJE2iOZePU+g
 EFPibbKd/Vt8ablub3D12RH3IFhNYdgMSo8dsdP0u6p6W0c5LCK0nEUDLg9zIszQ07Hr
 qJYw==
X-Gm-Message-State: AOAM531g+H/1qSanmUXiI6eMRPu1czjCvaW8xlXF8S98DvdJM8znlkMv
 aSIaphthjlLPneDuxN/I6pYRYnHmKUwNI1pPDbo=
X-Google-Smtp-Source: ABdhPJwKUsT+r6LVIMihxZOkGFIj9AhdyQFVhmnXgQgIU2Nv1YKdzY2xyvQNBbPj4bLz3JUi7OnLik525wHJdtmU/bY=
X-Received: by 2002:aca:4748:: with SMTP id u69mr3601361oia.5.1617120503756;
 Tue, 30 Mar 2021 09:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
In-Reply-To: <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Mar 2021 12:08:12 -0400
Message-ID: <CADnq5_O3cOD-zPB4kg_+qh=9oa=LayAsP38KK=R8480w7ish_g@mail.gmail.com>
Subject: Re: Interlaced resolutions hang the desktop
To: Alberto Salvia Novella <es20490446e@gmail.com>
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
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBNYXIgMzAsIDIwMjEgYXQgMTI6MDYgUE0gQWxiZXJ0byBTYWx2aWEgTm92ZWxsYQo8
ZXMyMDQ5MDQ0NmVAZ21haWwuY29tPiB3cm90ZToKPgo+IFRoaXMgaXMgd2h5IEknbSB1c2luZyBp
bnRlcmxhY2VkOgo+Cj4gJCB4cmFuZHIKPiBTY3JlZW4gMDogbWluaW11bSAzMjAgeCAyMDAsIGN1
cnJlbnQgMTkyMCB4IDEwODAsIG1heGltdW0gODE5MiB4IDgxOTIKPiBEaXNwbGF5UG9ydC0wIGRp
c2Nvbm5lY3RlZCAobm9ybWFsIGxlZnQgaW52ZXJ0ZWQgcmlnaHQgeCBheGlzIHkgYXhpcykKPiBI
RE1JLTAgY29ubmVjdGVkIHByaW1hcnkgMTkyMHgxMDgwKzArMCAobm9ybWFsIGxlZnQgaW52ZXJ0
ZWQgcmlnaHQgeCBheGlzIHkgYXhpcykgMTZtbSB4IDltbQo+ICAgIDE5MjB4MTA4MGkgICAgNjAu
MDAqKyAgNTAuMDAgICAgNTkuOTQKPiAgICAxOTIweDEwODAgICAgIDI0LjAwICAgIDIzLjk4Cj4g
ICAgMTI4MHg3MjAgICAgICA2MC4wMCAgICA1MC4wMCAgICA1OS45NAo+ICAgIDEwMjR4NzY4ICAg
ICAgNzUuMDMgICAgNzAuMDcgICAgNjAuMDAKPiAgICA4MzJ4NjI0ICAgICAgIDc0LjU1Cj4gICAg
ODAweDYwMCAgICAgICA3Mi4xOSAgICA3NS4wMCAgICA2MC4zMiAgICA1Ni4yNQo+ICAgIDcyMHg1
NzYgICAgICAgNTAuMDAKPiAgICA3MjB4NTc2aSAgICAgIDUwLjAwCj4gICAgNzIweDQ4MCAgICAg
ICA2MC4wMCAgICA1OS45NAo+ICAgIDcyMHg0ODBpICAgICAgNjAuMDAgICAgNTkuOTQKPiAgICA2
NDB4NDgwICAgICAgIDc1LjAwICAgIDcyLjgxICAgIDY2LjY3ICAgIDYwLjAwICAgIDU5Ljk0Cj4g
ICAgNzIweDQwMCAgICAgICA3MC4wOAo+IERWSS0wIGRpc2Nvbm5lY3RlZCAobm9ybWFsIGxlZnQg
aW52ZXJ0ZWQgcmlnaHQgeCBheGlzIHkgYXhpcykKPgo+IEkgdGhpbmsgdGhlIGRyaXZlciBzaG91
bGQgb25seSBzdXBwb3J0IHJlc29sdXRpb25zIHRoYXQgYXJlIHByb2dyZXNzaXZlLCBidXQgYWxz
byBhdCBsZWFzdCBvZiA1MEh6LgoKVGhlIHN1cHBvcnRlZCBkaXNwbGF5IG1vZGVzIGFyZSBkaWN0
YXRlZCBieSB0aGUgbW9uaXRvci4gIERvIHlvdSBzdGlsbApoYXZlIHByb2JsZW1zIHdpdGggcHJv
Z3Jlc3NpdmUgbW9kZXM/ICBJJ2QgaGF0ZSB0byBkaXNhYmxlIGludGVybGFjZWQKbW9kZXMgaWYg
dGhleSBhcmUgd29ya2luZyBmaW5lIGZvciBvdGhlcnMuCgpBbGV4CgoKPgo+IE9uIFR1ZSwgMzAg
TWFyIDIwMjEgYXQgMTU6NDEsIENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJr
ZW5AZ21haWwuY29tPiB3cm90ZToKPj4KPj4gTWhtLCBubyBpZGVhIHdoeSBhbiBpbnRlcmxhY2Vk
IHJlc29sdXRpb24gd291bGQgY2F1c2UgYSBjcmFzaC4gTWF5YmUgc29tZSBtaXNjYWxjdWxhdGlv
biBpbiB0aGUgZGlzcGxheSBjb2RlLgo+Pgo+PiBCdXQgYXBhcnQgZnJvbSB0aGF0IGlmIHlvdSBq
dXN0IGNvbm5lY3RlZCB5b3VyIFBDIHRvIGEgVFYgSSBhbHNvIHdvdWxkbid0IHJlY29tbWVuZCB1
c2luZyBhbiBpbnRlcmxhY2VkIHJlc29sdXRpb24gaW4gdGhlIGZpcnN0IHBsYWNlLgo+Pgo+PiBT
ZWUgdGhvc2UgcmVzb2x1dGlvbnMgb25seSBleGlzdHMgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxp
dHkgd2l0aCBhbmFsb2cgaGFyZHdhcmUuCj4+Cj4+IEkgdGhpbmsgd2Ugd291bGQganVzdCBkaXNh
YmxlIHRob3NlIG1vZGVzIGluc3RlYWQgb2Ygc2VhcmNoaW5nIGZvciB0aGUgYnVnLgo+Pgo+PiBS
ZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+Cj4+IEFtIDMwLjAzLjIxIHVtIDExOjA3IHNjaHJpZWIg
QWxiZXJ0byBTYWx2aWEgTm92ZWxsYToKPj4KPj4gSSBndWVzc2VkIHNvLgo+Pgo+PiBUaGUgR1BV
IGlzIGEgUmFkZW9uIEhENTg3MCwgYW5kIHRoZSBzY3JlZW4gaXMgYW4gb2xkIFRlbGVmdW5rZW4g
VFYgKFRMRksyMkxFRFBWUjEpLgo+Pgo+PiBTaW5jZSBteSByZWFsIGRpc3BsYXkgZ290IGludG8g
cmVwYWlyIEkgdXNlZCB0aGlzIFRWIG1lYW53aGlsZSwgYW5kIHRvIG15IHN1cnByaXNlIGl0IGZy
b3plIHRoZSBzeXN0ZW0uCj4+Cj4+IE9uIFR1ZSwgMzAgTWFyIDIwMjEgYXQgMTA6MTUsIENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4gSGkg
QWxiZXJ0bywKPj4+Cj4+PiB3ZWxsIHdoYXQgaGFyZHdhcmUgZG8geW91IGhhdmU/Cj4+Pgo+Pj4g
SW50ZXJsYWNlZCByZXNvbHV0aW9ucyBhcmUgbm90IHVzZWQgYW55IG1vcmUgb24gbW9kZXJuIGhh
cmR3YXJlLCBzbyB0aGV5Cj4+PiBhcmUgbm90IHdlbGwgdGVzdGVkLgo+Pj4KPj4+IFJlZ2FyZHMs
Cj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4gQW0gMzAuMDMuMjEgdW0gMTA6MDQgc2NocmllYiBBbGJl
cnRvIFNhbHZpYSBOb3ZlbGxhOgo+Pj4gPiBUaGUgZW50aXJlIGRlc2t0b3AgaGFuZ3MgYWZ0ZXIg
c29tZSBtaW51dGVzIHdoZW4gdXNpbmcgdGhlIG1vZHVsZQo+Pj4gPiAicmFkZW9uIiB3aXRoIGFu
IGludGVybGFjZWQgcmVzb2x1dGlvbi4KPj4+ID4KPj4+ID4gRWFzaWVyIHRvIHRyaWdnZXIgYnkg
cGxheWluZyBhIHZpZGVvIG9uIEZpcmVmb3gsIGF0IGxlYXN0IG9uIGt3aW5feDExLgo+Pj4gPiBX
YXlsYW5kIGRpZG4ndCBleGhpYml0IHRoZSBwcm9ibGVtLgo+Pj4gPgo+Pj4gPiBPdGhlciBkaXNw
bGF5IGRyaXZlcnMsIGZyb20gZGlmZmVyZW50IGNvbXB1dGVycyBJIGhhdmUgdHJpZWQsIGRpZG4n
dAo+Pj4gPiBhbGxvdyB0aG9zZSBpbnRlcmxhY2VkIHJlc29sdXRpb25zIGFsbCB0b2dldGhlci4g
SXQgc2VlbXMgdGhleSBrbm93Cj4+PiA+IHRoZXJlIHdpbGwgYmUgcHJvYmxlbXMuCj4+Pgo+Pgo+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPj4KPj4K
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
