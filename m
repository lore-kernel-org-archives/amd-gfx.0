From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: add gtt_sys_limit
Date: Tue, 27 Jun 2017 11:57:17 +0900
Message-ID: <e3546936-bd31-d650-b5c8-807822213827@daenzer.net>
References: <1498484397-1308-1-git-send-email-deathsimple@vodafone.de>
 <1498484397-1308-3-git-send-email-deathsimple@vodafone.de>
 <20170626233901.GA30922@kitsune.fastquake.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170626233901.GA30922-6hIufAJW0g7Gr8qjsLp7YGXnswh1EIUO@public.gmane.org>
Content-Language: en-CA
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
To: John Brooks <john-xq/Ko7C6e2Bl57MIdRCFDg@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: felix.kuehling-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjcvMDYvMTcgMDg6MzkgQU0sIEpvaG4gQnJvb2tzIHdyb3RlOgo+IE9uIE1vbiwgSnVuIDI2
LCAyMDE3IGF0IDAzOjM5OjU3UE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEZy
b206IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4KPj4gTGlt
aXQgdGhlIHNpemUgb2YgdGhlIEdBUlQgdGFibGUgZm9yIHRoZSBzeXN0ZW0gZG9tYWluLgo+Pgo+
PiBUaGlzIHNhdmVzIHVzIGEgYnVuY2ggb2YgdmlzaWJsZSBWUkFNLCBidXQgYWxzbyBsaW1pdGF0
ZXMgdGhlIG1heGltdW0gQk8gc2l6ZSB3ZSBjYW4gc3dhcCBvdXQuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAKPiBIbW0u
Cj4gCj4gT24gbXkgc3lzdGVtLCBHVFQgaXMgNDA5Nk1pQiAoMTA0ODU3NiBwYWdlcykuIEZvciB0
aGlzLCB0aGUgdGFibGUgdGFrZXMgdXAKPiAxMDQ4NTc2KjggYnl0ZXMgPSA4TWlCLiBSZWR1Y2lu
ZyBHVFQgdG8gMjU2TWlCICg2NTUzNiBwYWdlcykgd291bGQgcmVkdWNlIHRoZQo+IHNpemUgb2Yg
dGhlIHRhYmxlIHRvIDUxMiBLaUIuIEEgcmVsYXRpdmVseSBsYXJnZSBzYXZpbmcsIHRvIGJlIHN1
cmUuIEJ1dCBpbiB0aGUKPiBncmFuZGVyIHNjaGVtZSBvZiB0aGluZ3MsIGlzIHNhdmluZyA3LjVN
aUIgKDMlIG9mIHZpc2libGUgVlJBTSBAIDI1Nk0pIHdvcnRoCj4gY3V0dGluZyBHVFQgbWVtb3J5
IGJ5IGEgZmFjdG9yIG9mIDE2PwoKSSdtIGFmcmFpZCBub3QsIGVzcGVjaWFsbHkgc2luY2UgaXQg
d291bGQgbGltaXQgdGhlIG1heGltdW0gQk8gc2l6ZSB0byA8CjI1Nk1CLCBpZiBJIHVuZGVyc3Rh
bmQgY29ycmVjdGx5LiBQcmV0dHkgc3VyZSB0aGF0IHdvdWxkIGNhdXNlIGZhaWx1cmVzCndpdGgg
cmVhbCB3b3JsZCBhcHBzLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
