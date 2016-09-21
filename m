From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/i915: Before pageflip, also wait for shared dmabuf
 fences.
Date: Wed, 21 Sep 2016 12:30:19 +0200
Message-ID: <554f660d-cc8d-295e-42aa-c374e95bdc8a@vodafone.de>
References: <1473293683-6247-1-git-send-email-mario.kleiner.de@gmail.com>
 <20160908063038.GB28919@nuc-i3427.alporthouse.com>
 <9e28ae2e-ed2f-ef0e-8690-1f78f5aed18b@gmail.com>
 <20160908162346.GA5479@nuc-i3427.alporthouse.com>
 <abccc8ac-10c6-ab22-c59d-f43ee48ba78d@daenzer.net>
 <bdd0653d-e4d6-fbbe-89f1-b1104682bf02@vodafone.de>
 <20160913093945.GA25204@nuc-i3427.alporthouse.com>
 <9c0f86d0-eb23-7110-c663-01859132ac83@vodafone.de>
 <7aafce92-8bcf-1c5c-45de-9e8ecda85239@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7aafce92-8bcf-1c5c-45de-9e8ecda85239-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjEuMDkuMjAxNiB1bSAxMTo1NiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+Cj4gTG9va3Mg
bGlrZSB0aGVyZSBhcmUgZGlmZmVyZW50IGludGVycHJldGF0aW9ucyBvZiB0aGUgc2VtYW50aWNz
IG9mCj4gZXhjbHVzaXZlIHZzLiBzaGFyZWQgZmVuY2VzLiBXaGVyZSBhcmUgdGhlc2Ugc2VtYW50
aWNzIGRvY3VtZW50ZWQ/CgpZZWFoLCBJIHRoaW5rIGFzIHdlbGwgdGhhdCB0aGlzIGlzIHRoZSBw
cmltYXJ5IHF1ZXN0aW9uIGhlcmUuCgpJSVJDIHRoZSBmZW5jZXMgd2VyZSBleHBsaWNpdGx5IGNh
bGxlZCBleGNsdXNpdmUvc2hhcmVkIGluc3RlYWQgb2YgCndyaXRpbmcvcmVhZGluZyBvbiBwdXJw
b3NlLgoKSSBhYnNvbHV0ZWx5IGRvbid0IG1pbmQgc3dpdGNoaW5nIHRvIHRoZW0gdG8gd3JpdGlu
Zy9yZWFkaW5nIHNlbWFudGljcywgCmJ1dCBhbWRncHUgcmVhbGx5IG5lZWRzIG11bHRpcGxlIHdy
aXRlcnMgYXQgdGhlIHNhbWUgdGltZS4KClNvIGluIHRoaXMgY2FzZSB0aGUgd3JpdGluZyBzaWRl
IG9mIGEgcmVzZXJ2YXRpb24gb2JqZWN0IG5lZWRzIHRvIGJlIGEgCmNvbGxlY3Rpb24gb2YgZmVu
Y2VzIGFzIHdlbGwuCgo+IEZXSVcsIHdlIHNlZW0gdG8gaGF2ZSB0aGUgc2FtZSBpc3N1ZSB3aXRo
IHJhZGVvbiB2cy4gYW1kZ3B1OiByYWRlb24gb25seQo+IHNlZW1zIHRvIHdhaXQgZm9yIGV4Y2x1
c2l2ZSBmZW5jZXMsIHNvIGUuZy4gcnVubmluZyBYb3JnIG9uIGFtZGdwdSBhbmQKPiB1c2luZyBQ
UklNRSBzbGF2ZSBzY2Fub3V0IG9uIHJhZGVvbiBsZWF2ZXMgYXJ0aWZhY3RzLgoKWWVhaCwgSSBr
bm93LiBTZWUgcmFkZW9uX2Rpc3BsYXkuYyByYWRlb25fZmxpcF93b3JrX2Z1bmMoKS4KCldlIHBy
ZXR0eSBtdWNoIG5lZWQgdGhlIHNhbWUgcGF0Y2ggaGVyZSBJJ3ZlIGRvbmUgZm9yIGFtZGdwdSBh
cyB3ZWxsLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
