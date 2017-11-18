From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix VA hole handling on Vega10 v2
Date: Sat, 18 Nov 2017 15:31:52 +0100
Message-ID: <17f339f2-20fa-1aba-8ddb-86ce320fd3ce@gmail.com>
References: <20171116102252.10173-1-christian.koenig@amd.com>
 <d995f9a6-f76a-aa7c-4b61-fe848bfb549a@gmail.com>
 <d5aafe10-1b90-ceeb-db50-99afb412eccb@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d5aafe10-1b90-ceeb-db50-99afb412eccb-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTcuMTEuMjAxNyB1bSAxNzowOSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDE3LzEx
LzE3IDExOjI4IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBQaW5nPyBNaWNoZWwsIEFs
ZXggY2FuIHNvbWVib2R5IHRha2UgYSBsb29rPwo+IFBhdGNoIDIgaXMKPgo+IFJldmlld2VkLWJ5
OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPgo+Cj4gV2l0aCBwYXRj
aGVzIDEgJiAzLCBpdCdzIG5vdCAxMDAlIGNsZWFyIHRvIG1lIHdoYXQgdGhlIGlkZWEgaXMgYmVo
aW5kCj4gdGhlIGhhbmRsaW5nIG9mIHRoZSBob2xlIG9uIHRoZSBrZXJuZWwgYW5kIHVzZXJzcGFj
ZSBzaWRlLiBNYXliZSB5b3UgY2FuCj4gYWRkIHNvbWUgZXhwbGFuYXRpb24gaW4gY29kZSBjb21t
ZW50cyBvciB0aGUgY29tbWl0IGxvZ3M/ClllYWgsIHRoYXQgaXMgYWN0dWFsbHkgYSBiaXQgb2Yg
YSBtZXNzIGJlY2F1c2UgdGhlIGhhcmR3YXJlIApkb2N1bWVudGF0aW9uIHdhc24ndCB2ZXJ5IGNs
ZWFyIG9uIGhvdyB0aGlzIHdvcmtzLgoKSG93IGFib3V0IHRoaXMgYXMgZXh0cmEgY29kZSBjb21t
ZW50IG9uIHBhdGNoIDEgdG8gdGhlIGFzc2lnbm1lbnQgb2YgCmRldl9pbmZvLnZpcnR1YWxfYWRk
cmVzc19tYXg6CgovKgogwqAqIE9sZCB1c2Vyc3BhY2UgaXNuJ3QgYXdhcmUgb2YgdGhlIFZBIGhv
bGUgb24gVmVnYTEwLiBTbyBpbiB0aGVvcnkgYW4gCmNsaWVudCBjb3VsZCBnZXQgaW52YWxpZCBW
QSBhZGRyZXNzZXMgYXNzaWduZWQuCiDCoCogVG8gZml4IHRoaXMgYW5kIGtlZXAgYmFja3dhcmQg
Y29tcGF0aWJpbGl0eSB3ZSBsaW1pdCB0aGUgVkEgc3BhY2UgCnJlcG9ydGVkIGluIHRoaXMgZmll
bGQgdG8gdGhlIHJhbmdlIGJlbG93IHRoZSBob2xlLgogwqAqLwoKVGhlIGxhc3QgcGF0Y2ggaXMg
dGhlbiB0byByZXBvcnQgdGhlIFZBIHNwYWNlIGFib3ZlIHRoZSBob2xlLCBjYXVzZSB0aGF0IApp
cyBhY3R1YWxseSB3aGF0IGxpYmRybSBzaG91bGQgdXNlLgoKVGhlIGNydXggaXMgd2hlbiBJIHB1
dCB0aGUgVkEgc3BhY2UgYWJvdmUgdGhlIGhvbGUgZGlyZWN0bHkgaW50byB0aGUgb2xkIApmaWVs
ZHMgb2xkZXIgdmVyc2lvbnMgb2YgbGliZHJtIHdvdWxkIGJyZWFrIGFuZCB3ZSBjYW4ndCBkbyB0
aGF0LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
