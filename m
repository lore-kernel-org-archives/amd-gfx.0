From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Use dev_info() to report amdkfd is not
 supported for this ASIC
Date: Mon, 28 May 2018 12:41:20 +0300
Message-ID: <CAFCwf12SEcm+o2efDBN-ogEEp9qY=jtMzZbJPMs6d2u7dHHmGw@mail.gmail.com>
References: <1527196034-29268-1-git-send-email-tstellar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527196034-29268-1-git-send-email-tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Tom Stellard <tstellar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBNYXkgMjUsIDIwMTggYXQgMTI6MDcgQU0sIFRvbSBTdGVsbGFyZCA8dHN0ZWxsYXJA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gVGhpcyBpcyBhbiBpbXBvcnRhbnQgbWVzc2FnZSwgc28gaXQg
c2hvdWxkIGJlIHZpc2libGUgdG8gdXNlcnMgd2l0aG91dAo+IGhhdmluZyB0byBlbmFibGUgZXh0
cmEgZGVidWdnaW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogVG9tIFN0ZWxsYXJkIDx0c3RlbGxhckBy
ZWRoYXQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+IGlu
ZGV4IDRkMzYyMDNmZmIxMS4uYzE4YTMzMmU3OTBiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYwo+IEBAIC05Myw3ICs5Myw3IEBAIHZvaWQgYW1kZ3B1
X2FtZGtmZF9kZXZpY2VfcHJvYmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAgICAg
ICAgICAgICAgIGtmZDJrZ2QgPSBhbWRncHVfYW1ka2ZkX2dmeF84XzBfZ2V0X2Z1bmN0aW9ucygp
Owo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgIGRlZmF1bHQ6Cj4gLSAgICAgICAg
ICAgICAgIGRldl9kYmcoYWRldi0+ZGV2LCAia2ZkIG5vdCBzdXBwb3J0ZWQgb24gdGhpcyBBU0lD
XG4iKTsKPiArICAgICAgICAgICAgICAgZGV2X2luZm8oYWRldi0+ZGV2LCAia2ZkIG5vdCBzdXBw
b3J0ZWQgb24gdGhpcyBBU0lDXG4iKTsKPiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+ICAgICAg
ICAgfQo+Cj4gLS0KPiAyLjE3LjAKPgoKVGhpcyBwYXRjaCBpczoKUmV2aWV3ZWQtYnk6IE9kZWQg
R2FiYmF5IDxvZGVkLmdhYmJheUBnbWFpbC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
