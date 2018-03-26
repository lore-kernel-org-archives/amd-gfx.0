From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dma-buf: use parameter structure for dma_buf_attach
Date: Mon, 26 Mar 2018 12:47:01 +0200
Message-ID: <0242b504-87cd-2c80-ad86-868622c3c681@gmail.com>
References: <20180325113451.2425-1-christian.koenig@amd.com>
 <20180326083638.GS14155@phenom.ffwll.local>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180326083638.GS14155-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
Content-Language: en-US
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMjYuMDMuMjAxOCB1bSAxMDozNiBzY2hyaWViIERhbmllbCBWZXR0ZXI6Cj4gT24gU3VuLCBN
YXIgMjUsIDIwMTggYXQgMDE6MzQ6NTFQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToK
W1NOSVBdCj4+IC0JYXR0YWNoLT5kZXYgPSBkZXY7Cj4+ICsJYXR0YWNoLT5kZXYgPSBpbmZvLT5k
ZXY7Cj4+ICAgCWF0dGFjaC0+ZG1hYnVmID0gZG1hYnVmOwo+PiArCWF0dGFjaC0+cHJpdiA9IGlu
Zm8tPnByaXY7Cj4gVGhlIC0+cHJpdiBmaWVsZCBpcyBmb3IgdGhlIGV4cG9ydGVyLCBub3QgdGhl
IGltcG9ydGVyLiBTZWUgZS5nLgo+IGRybV9nZW1fbWFwX2F0dGFjaC4gWW91IGNhbid0IGxldCB0
aGUgaW1wb3J0ZXIgc2V0IHRoaXMgbm93IHRvbywgc28gbmVlZHMKPiB0byBiZSByZW1vdmVkIGZy
b20gdGhlIGluZm8gc3RydWN0LgoKQ3JhcCwgaW4gdGhpcyBjYXNlIEkgbmVlZCB0byBhZGQgYW4g
aW1wb3J0ZXJfcHJpdiBmaWVsZCBiZWNhdXNlIHdlIG5vdyAKbmVlZCB0byBtYXAgZnJvbSB0aGUg
YXR0YWNobWVudCB0byBpdCdzIGltcG9ydGVyIG9iamVjdCBhcyB3ZWxsLgoKVGhhbmtzIGZvciBu
b3RpY2luZyB0aGlzLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
