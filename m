Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7680FC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 20:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4673A20658
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 20:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QybsQxJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4673A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D46389B60;
	Mon, 10 Aug 2020 20:35:51 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED16E89B60
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 20:35:49 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t14so784540wmi.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rj9eDSRUMS+uoQYuFAG8NxQuUnLDOM6gUVvpTrrcc8w=;
 b=QybsQxJy/ElzjYPLGbTsU/V8hleE5mE6MAqb3CN+8bjIDiEzMYYctbRm3KiA/O+W0+
 rwUdf8vPY5tCPP/BkjSJM5fF5d3Cq5f71/15cpTM5+SM1ov8SkvVKCwjEHpmW/ltg2ku
 1GBp5RP1kpFpLPrmUduqMb9p1800gj4eNPhfBCi8xjZd/7W4/JIhRWWpBftKwsP7f/lS
 gylzj0kBSVcvxnj8qRGtTyaLfE0y6pgMsYwtk+i75Pz3NzTVNfs+ulSReUEIuhah2Wco
 V+2zo0zMLLAdRQRbKyD3bte+IcjwpWDkuznlk3if8uQFjDaVWRiJWWljzEvDb0UwDl4m
 XCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rj9eDSRUMS+uoQYuFAG8NxQuUnLDOM6gUVvpTrrcc8w=;
 b=GrWWUVSvrZPccAqzpnjM9PdQzaCLijG+k0jpiR9RAOKm5PIDmsIhlU5v3+U5tSZHMr
 os3YphNHzMhonJOqXc/hS/kusSFKw8S+jdPJG4X6xEHpNRE6dBVNGPdKRU7I1TiNN2Y0
 fPQ6psTpzg9CSvakPMsS+HFe9lfMiB9mREJ/dYIcAaD1FAs50wgREw8vz3OJot7lBjQ1
 ys2RT93pOL24MX3/5X7MC6e9vDeNNwDeRxnrE+h5Z3x7grsxNKykNe4odcB5dSa4Zj4I
 H6b+BLHV/2Og1e3KoGYP1SJsJa8xFW4S0o0Opf3IrxoRTW9Jd2BNmb6sy0RMUxnoP+jA
 FwaQ==
X-Gm-Message-State: AOAM5310vyJTiqk7ow2SHuGoxh08wk5sjU+HTAJ0GcS/oXeQiG1qi+kj
 ibMVCC/M2zgNOhcdYAz06P1I0IjXZ/3kVI4CU3s=
X-Google-Smtp-Source: ABdhPJwHB9sIi+j3T1OLW8JLlCEir2qtZHzNKYnP01f0oYBnT1ztBA/Al7WGFDeax9Yn3C2g7QwGWG39DVsnYOgmVgg=
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr909508wmj.56.1597091748595; 
 Mon, 10 Aug 2020 13:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAB-2Q08KQmS0D06k1QEUpccybGqCY+HYaZkF=sY0t1EX8Y_u2Q@mail.gmail.com>
 <alpine.LNX.2.20.13.2008100928010.2454@monopod.intra.ispras.ru>
 <3f687bb2-d5c0-d538-53f4-af2b444bb1b6@gmail.com>
In-Reply-To: <3f687bb2-d5c0-d538-53f4-af2b444bb1b6@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2020 16:35:37 -0400
Message-ID: <CADnq5_P6SSJCiHkZfgzZcMLbFOG1_qHe8D+oQgZppXQhEEhttQ@mail.gmail.com>
Subject: Re: Non-deterministically boot into dark screen with `amdgpu`
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alexander Monakov <amonakov@ispras.ru>, Ignat Insarov <kindaro@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBBdWcgMTAsIDIwMjAgYXQgNzo0NiBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBIaSBndXlzLAo+Cj4gQW0gMTAu
MDguMjAgdW0gMDg6NDMgc2NocmllYiBBbGV4YW5kZXIgTW9uYWtvdjoKPgo+IEhpLAo+Cj4geW91
IHNob3VsZCDQodGBIGEgc3BlY2lhbGl6ZWQgbWFpbGluZyBsaXN0IGFuZCBhIHJlbGV2YW50IG1h
aW50YWluZXIsCj4gb3RoZXJ3aXNlIHlvdXIgZW1haWwgaXMgbGlrZWx5IHRvIGJlIGlnbm9yZWQg
YXMgTEtNTCBpcyBhbiBpbmNyZWRpYmx5Cj4gaGlnaC12b2x1bWUgbGlzdC4gQWRkaW5nIGFtZC1n
ZnggYW5kIEFsZXggRGV1Y2hlci4KPgo+Cj4gVGhhbmtzIGZvciBmb3J3YXJkaW5nIHRoaXMuIEFG
QUlLIHdlIGhhdmVuJ3QgaGVhcmQgb2YgdGhpcyBidWcgYmVmb3JlLCBidXQgQWxleCBhbHJlYWR5
IG1pZ2h0IGtub3cgbW9yZSBhYm91dCBpdC4KPgo+IE1vcmUgdGhvdWdodHMgYmVsb3cuCj4KPiBP
biBTdW4sIDkgQXVnIDIwMjAsIElnbmF0IEluc2Fyb3Ygd3JvdGU6Cj4KPiBIZWxsbyEKPgo+IFRo
aXMgaXMgYW4gaXNzdWUgcmVwb3J0LuKAgkkgYW0gbm90IGZhbWlsaWFyIHdpdGggdGhlIExpbnV4
IGtlcm5lbAo+IGRldmVsb3BtZW50IHByb2NlZHVyZSwgc28gcGxlYXNlIGRpcmVjdCBtZSB0byBh
IG1vcmUgYXBwcm9wcmlhdGUgb3IKPiBzcGVjaWFsaXplZCBtZWRpdW0gaWYgdGhpcyBpcyBub3Qg
dGhlIHJpZ2h0IGF2ZW51ZS4KPgo+IE15IGxhcHRvcCAoUnl6ZW4gNyBQcm8gQ1BVL0dQVSkgYm9v
dHMgaW50byBkYXJrIHNjcmVlbiBtb3JlIG9mdGVuIHRoYW4KPiBub3Qu4oCCU2NyZWVuIGJsYWNr
bmVzcyBjb3JyZWxhdGVzIHdpdGggYSBsaW5lIGluIHRoZSBgc3lzdGVtZGAgam91cm5hbAo+IHRo
YXQgc2F5cyBgUkFNIHdpZHRoIE5iaXRzIEREUjRgLCB3aGVyZSBOIGlzIGVpdGhlciAxMjggKHJl
c3VsdGluZyBpbgo+IGRhcmsgc2NyZWVuKSBvciA2NCAocmVzdWx0aW5nIGluIGEgaGVhbHRoeSBi
b290KS7igIJUaGUgbnVtYmVyIHNlZW1zIHRvCj4gYmUgY2hvc2VuIGF0IHJhbmRvbSB3aXRoIGJp
YXMgdG93YXJkcyAxMjgu4oCCVGhpcyBoYXMgYmVlbiBnb2luZyBvbiBmb3IKPiBhIHdoaWxlIHNv
IGhlcmUgaXMgc29tZSBzdGF0aXN0aWNzOgo+Cj4gKiAzNTYgYm9vdHMgcHJvY2VlZCBmYXIgZW5v
dWdoIHRvICBhdHRlbXB0IG1vZGUgc2V0dGluZy4KPiAqIDgyIGJvb3RzIHNldCBSQU0gd2lkdGgg
dG8gNjQgYml0cyBhbmQgcHJlc3VtYWJseSBzdWNjZWVkLgo+ICogMjc0IGJvb3RzIHNldCBSQU0g
d2lkdGggdG8gMTI4IGJpdHMgYW5kIHByZXN1bWFibHkgZmFpbC4KPgo+IFRoZSBpc3N1ZSBpcyBw
cmV2ZW50ZWQgd2l0aCB0aGUgYG5vbW9kZXNldGAga2VybmVsIG9wdGlvbi4KPgo+IEkgcmVwb3J0
ZWQgdGhpcyBwcmV2aW91c2x5IChhYm91dCBhIHllYXIgYWdvKSBvbiB0aGUgZm9ydW0gb2YgbXkg
TGludXgKPiBkaXN0cmlidXRpb24uWzFd4oCCVGhlIGlzc3VlIHN0aWxsIHBlcnNpc3RzIGFzIG9m
ICBsaW51eCA1LjguMC4KPgo+IFRoZSBkZXRhaWxzIG9mIG15IGdyYXBoaWNzIGNvbnRyb2xsZXIs
IGFzIHdlbGwgYXMgc29tZSBqb3VybmFsCj4gZXhjZXJwdHMsIGNhbiBiZSBzZWVuIGF0IFsxXS7i
gIJPbmUgdGhpbmcgdGhhdCBoYXMgY2hhbmdlZCBzaW5jZSB0aGVuIGlzCj4gdGhhdCBvbiBmYWls
dXJlLCB0aGVyZSBub3cgYXBwZWFycyBhIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSBlcnJvci7i
gIJJCj4gYW0gYXR0YWNoaW5nIHRoZSBsb2cgb2Yga2VybmVsIG1lc3NhZ2VzIGZyb20gdGhlIG1v
c3QgcmVjZW50IGZhaWxlZAo+IGJvb3Qg4oCUIHBsZWFzZSByZXF1ZXN0IG1vcmUgaW5mb3JtYXRp
b24gaWYgbmVlZGVkLgo+Cj4gSSBhcHByZWNpYXRlIGFueSBkaXJlY3Rpb25zIGFuZCBhZHZpY2Ug
YXMgdG8gaG93IEkgbWF5IGdvIGFib3V0IGZpeGluZwo+IHRoaXMgYW5ub3lhbmNlLgo+Cj4gWzFd
OiBodHRwczovL2Jicy5hcmNobGludXgub3JnL3ZpZXd0b3BpYy5waHA/aWQ9MjQ4MjczCj4KPiBP
biB0aGUgZm9ydW0geW91IHNob3cgdGhhdCBpbiB0aGUgInN1Y2Nlc3MiIGNhc2UgdGhlcmUncyBv
bmUgbGVzcyAiQklPUwo+IHNpZ25hdHVyZSBpbmNvcnJlY3QiIG1lc3NhZ2UuIFRoaXMgaW1wbGll
cyB0aGF0IGFtZGdwdV9nZXRfYmlvcygpIGluCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Jpb3MuYwo+IGdldHMgdGhlIHZpZGVvIEJJT1MgZnJvbSBh
IGRpZmZlcmVudCBzb3VyY2UuIElmIHRoYXQgaGFwcGVucyBldmVyeSB0aW1lCj4gKG9uZSAic2ln
bmF0dXJlIGluY29ycmVjdCIgbWVzc2FnZSBmb3IgInN1Y2Nlc3MiLCB0d28gZm9yICJmYWlsdXJl
IikKPiB0aGF0IG1heSBiZSByZWxldmFudCB0byB0aGUgcHJvYmxlbSB5b3UncmUgZXhwZXJpZW5j
aW5nLgo+Cj4gSWYgeW91IGRvbid0IG1pbmQgcGF0Y2hpbmcgYW5kIHJlYnVpbGRpbmcgdGhlIGtl
cm5lbCBJIHN1Z2dlc3QgYWRkaW5nCj4gZGVidWcgcHJpbnRrcyB0byB0aGUgYWZvcmVtZW50aW9u
ZWQgZnVuY3Rpb24gdG8gc2VlIGV4YWN0bHkgd2hpY2ggbWV0aG9kcwo+IGZhaWwgd2l0aCB3cm9u
ZyBzaWduYXR1cmUgYW5kIHdoaWNoIHN1Y2NlZWRzLgo+Cj4gQWxzbyBtaWdodCBiZSB3b3J0aHdo
aWxlIHRvIGNoZWNrIGlmIHRoZXJlJ3MgYSBCSU9TIHVwZGF0ZSBmb3IgeW91ciBsYXB0b3AuCj4K
Pgo+IEl0IG1pZ2h0IGFsc28gYmUgYSBnb29kIGlkZWEgdG8gdHJ5IHRoZSBsYXRlc3QgYW1kLXN0
YWdpbmctZHJtLW5leHQgYnJhbmNoIGZyb20gQWxleCByZXBvc2l0b3J5IChiZWFyIHdpdGggbWUg
SSBkb24ndCBoYXZlIHRoZSBsaW5rIGF0IGhhbmQsIGJ1dCBpdCBzaG91bGQgYmUgZWFzeSB0byBm
aW5kKS4KPgo+IE9wZW5pbmcgYSBidWcgcmVwb3J0IG9yIHNlYXJjaGluZyB0aGUgZXhpc3Rpbmcg
b25lcyBmb3Igc29tZXRoaW5nIHNpbWlsYXIgdW5kZXIgaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0
b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMgbWlnaHQgYmUgYSBnb29kIGlkZWEgYXMgd2VsbC4KPgo+
IEFuZCBJIGNvbXBsZXRlbHkgYWdyZWUgdGhhdCB0aGlzIHNvdW5kcyBsaWtlIGFuIGlzc3VlIGdl
dHRpbmcgdGhlIEJJT1MgaW1hZ2UuCgpJJ3ZlIG5vdCBoZWFyZCBvZiBhbiBpc3N1ZSBsaWtlIHRo
aXMgZWl0aGVyLiAgQmVzdCB0byBmaWxlIGEgZ2l0bGFiCmJ1ZyBhbmQgYXR0YWNoIHlvdXIgZnVs
bCBkbWVzZyBvdXRwdXQgaW4gYm90aCB0aGUgd29ya2luZyBhbmQKbm9uLXdvcmtpbmcgY2FzZXMg
YW5kIHdlIGNhbiBnbyBmcm9tIHRoZXJlLgoKQWxleAoKPgo+IFRoYW5rcywKPiBDaHJpc3RpYW4u
Cj4KPgo+IEFsZXhhbmRlcgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
