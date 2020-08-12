Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA69C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 15:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B37020885
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 15:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B37020885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91DA6E906;
	Wed, 12 Aug 2020 15:28:41 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22DA6E8DC;
 Wed, 12 Aug 2020 15:19:22 +0000 (UTC)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC83C207F7;
 Wed, 12 Aug 2020 15:19:21 +0000 (UTC)
Date: Wed, 12 Aug 2020 11:19:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: adjust the pid in the grab_id trace point
Message-ID: <20200812111920.06efa663@oasis.local.home>
In-Reply-To: <e48b6300-7ba7-f2fc-b7f7-a205d32607a4@gmail.com>
References: <20200807133658.1866-1-christian.koenig@amd.com>
 <20200807133658.1866-2-christian.koenig@amd.com>
 <20200812141755.GA8136@home.goodmis.org>
 <e48b6300-7ba7-f2fc-b7f7-a205d32607a4@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 12 Aug 2020 15:28:41 +0000
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
Cc: Shashank.Sharma@amd.com, daniel.vetter@ffwll.ch,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAxMiBBdWcgMjAyMCAxNjozNjozNiArMDIwMApDaHJpc3RpYW4gS8O2bmlnIDxja29l
bmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cgo+IEFtIDEyLjA4LjIwIHVtIDE2
OjE3IHNjaHJpZWIgU3RldmVuIFJvc3RlZHQ6Cj4gPiBPbiBGcmksIEF1ZyAwNywgMjAyMCBhdCAw
MzozNjo1OFBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOiAgCj4gPj4gVHJhY2Ugc29t
ZXRoaW5nIHVzZWZ1bCBpbnN0ZWFkIG9mIHRoZSBwaWQgb2YgYSBrZXJuZWwgdGhyZWFkIGhlcmUu
Cj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4gPj4gLS0tCj4gPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHJhY2UuaCB8IDEgKwo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
Cj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3RyYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+ID4+
IGluZGV4IDVkYTIwZmMxNjZkOS4uMDdmOTllZjY5ZDkxIDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4gPj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPiA+PiBAQCAtMjI4LDYgKzIyOCw3IEBA
IFRSQUNFX0VWRU5UKGFtZGdwdV92bV9ncmFiX2lkLAo+ID4+ICAgCQkJICAgICApLAo+ID4+ICAg
Cj4gPj4gICAJICAgIFRQX2Zhc3RfYXNzaWduKAo+ID4+ICsJCQkgICBfX2VudHJ5LT5lbnQucGlk
ID0gdm0tPnRhc2tfaW5mby5waWQ7ICAKPiA+IElmIHRoZSBlbnQucGlkIGlzIG5vdCB0aGUgcGlk
IHlvdSBhcmUgaW50ZXJlc3RlZCBpbiBmb3IgdGhpcyB0cmFjZSBldmVudCwganVzdAo+ID4gYWRk
IGEgInBpZCIgZmllbGQgdG8gdGhlIHRyYWNlIGV2ZW50IGFuZCBwbGFjZSBpdCB0aGVyZS4gRG8g
bm90IG1vZGlmeSB0aGUKPiA+IGdlbmVyaWMgcGlkIHRoYXQgaXMgcmVjb3JkZWQsIGFzIHdlIHdv
dWxkIGxpa2UgdGhhdCB0byBiZSBjb25zaXN0ZW50IGZvciBhbGwKPiA+IHRyYWNlIGV2ZW50cy4g
IAo+IAo+IFRoZSBwcm9ibGVtIG15IHVzZXJzcGFjZSBndXlzIGhhdmUgaXMgdGhhdCB0aGlzIGRv
ZXNuJ3Qgd29yayB3aXRoIAo+ICJ0cmFjZS1jbWQgLVAgJHBpZCIuCj4gCj4gQnV0IEkgdGhpbmsg
SSBjYW4gdGVhY2ggdGhlbSBob3cgZmlsdGVycyB3b3JrIDopCgpZZXAsIHRyYWNlLWNtZCByZWNv
cmQgLWUgZXZlbnQgLWYgInBpZCA9PSAkcGlkIgoKPiAKPiA+IFRoZSAiZW50LnBpZCIgdHVybnMg
aW50byAiY29tbW9uX3BpZCIgaW4gdGhlIGZpZWxkLCBsZWF2aW5nICJwaWQiIGZyZWUgdG8gdXNl
Lgo+ID4gT3RoZXIgdHJhY2UgZXZlbnRzIChsaWtlIHNjaGVkX3dha2luZykgcmVjb3JkIGEgcGlk
IGZpZWxkIHRoYXQgaXMgbm90IHRoZSBzYW1lCj4gPiBhcyB0aGUgcGlkIG9mIHRoZSBleGVjdXRp
bmcgdGFzay4gIAo+IAo+IFllcywgd2UgdGhvdWdodCBhYm91dCB0aGlzIGFsdGVybmF0aXZlIGFz
IHdlbGwuCj4gCj4gPiBUaGUgImVudC5waWQiIHNob3VsZCBhbHdheXMgYmUgdGhlIHBpZCBvZiB0
aGUgdGFzayB0aGF0IGV4ZWN1dGVkIHRoZSBldmVudC4gIAo+IAo+IFdoeT8gRm9yIHRoZSBjYXNl
IGhlcmUgd2UganVzdCBleGVjdXRlIGEgd29yayBpdGVtIGluIHRoZSBiYWNrZ3JvdW5kIGZvciAK
PiBhbiB1c2Vyc3BhY2UgcHJvY2Vzcy4KPiAKPiBUcmFjaW5nIHRoZSBwaWQgb2YgdGhlIHdvcmtl
ciBwb29sIHdoaWNoIGV4ZWN1dGVzIGl0IGRvZXNuJ3Qgc2VlbSB0byAKPiBtYWtlIHRvIG11Y2gg
c2Vuc2UuCgpNYXliZSBub3QgZm9yIHlvdSwgYnV0IGl0IGRvZXMgZm9yIG1lLiBBbGwgdHJhY2Ug
ZXZlbnRzIHNob3cgd2hhdApoYXBwZW5lZCB3aGVuIGl0IGhhcHBlbmVkIGFuZCB3aG8gZXhlY3V0
ZWQgaXQuIEkgbGlrZSB0byBzZWUgd2hhdAp3b3JrZXIgdGhyZWFkcyBhcmUgZXhlY3V0aW5nLiBJ
IG1heSBmaWx0ZXIgb24gdGhlIHdvcmtlciB0aHJlYWQsIGFuZCBieQpjaGFuZ2luZyB0aGUgZW50
LnBpZCwgSSB3b250IHNlZSB3aGF0IGl0IGlzIGRvaW5nLgoKVGhhdCBzYWlkLCBJIHRoaW5rIEkg
bWF5IGFkZCBhIGZlYXR1cmUgdG8gYSB0cmFjZSBldm50IGZvciBhIHNwZWNpYWwgZmlsdGVyCnRv
IHNheSwgInRlc3QgZmllbGQgdG8gdGhlIHNldF9ldmVudF9waWQiLCBhbmQgaWYgaXQgZXhpc3Rz
IGluIHRoYXQKZmlsZSB0byBpbmNsdWRlIHRoYXQgZXZlbnQgaW4gdGhlIGZpbHRlcmVkIHRyYWNl
LiBUaGlzIHdvdWxkIGluY2x1ZGUKc2NoZWRfd2FraW5nIHRyYWNlIGV2ZW50cyBhcyB3ZWxsLgoK
VGhhdCB3YXkgInRyYWNlLWNtZCByZWNvcmQgLVAgJHBpZCIgd2lsbCBzdGlsbCB3b3JrIGZvciB5
b3VyIGNhc2UuCgotLSBTdGV2ZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
