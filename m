From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 2/4] drm/ttm: consistently use reservation_object_unlock
Date: Wed, 8 Nov 2017 17:41:26 +0100
Message-ID: <089ed82b-02c9-0b73-6bfd-a0ef39215ba7@gmail.com>
References: <20171108145936.27071-1-christian.koenig@amd.com>
 <20171108145936.27071-2-christian.koenig@amd.com>
 <ebffaae6-675a-1a7b-9a48-b816c1c5bf40@daenzer.net>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <ebffaae6-675a-1a7b-9a48-b816c1c5bf40@daenzer.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Hongbo.He@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDguMTEuMjAxNyB1bSAxNzozNiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDA4LzEx
LzE3IDAzOjU5IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBJbnN0ZWFkIG9mIGhhdmlu
ZyBhIHBvaW50bGVzcyB3cmFwcGVyIG9yIGNhbGwgdGhlIHVuZGVybHlpbmcgd3dfbXV0ZXgKPj4g
ZnVuY3Rpb24gZGlyZWN0bHkuCj4gTm90IHN1cmUgSSBjYW4gYWdyZWUgaXQncyBwb2ludGxlc3Ms
IHNpbmNlIGl0IHJlY2VudGx5IHRvb2sgbWUgYSB3aGlsZQo+IHRvIHJlYWxpemUgdGhhdCB1bmxv
Y2tpbmcgYm8tPnJlc3YgaXMgZXNzZW50aWFsbHkgdGhlIHNhbWUgYXMKPiB1bnJlc2VydmluZyB0
aGUgQk8uCgpPayBpbiB0aGlzIGNhc2UgbGV0J3MgY2FsbCB0aGlzIGNvbmZ1c2luZy4gQnV0IHll
YWggdGhhdCAKX190dG1fYm9fdW5yZXNlcnYoYm8pLCByZXNlcnZhdGlvbl9vYmplY3RfdW5sb2Nr
KGJvLT5yZXN2KSBhbmQgCnd3X211dGV4X3VubG9jaygmYm8tPnJlc3YtPmxvY2spIGFyZSBlc3Nl
bnRpYWxseSB0aGUgc2FtZSB0aGluZyBpcyAKZXhhY3RseSB3aGF0IEkgd2FudCB0byBmaXggaGVy
ZS4KCj4gQW55d2F5LCB0aGlzIGJyZWFrcyB0aGUgcXhsIGRyaXZlcjoKPgo+IGRyaXZlcnMvZ3B1
L2RybS8vcXhsL3F4bF9yZWxlYXNlLmM6IEluIGZ1bmN0aW9uIOKAmHF4bF9yZWxlYXNlX2ZlbmNl
X2J1ZmZlcl9vYmplY3Rz4oCZOgo+IGRyaXZlcnMvZ3B1L2RybS8vcXhsL3F4bF9yZWxlYXNlLmM6
NDcyOjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhfX3R0bV9i
b191bnJlc2VydmXigJk7IGRpZCB5b3UgbWVhbiDigJh0dG1fYm9fdW5yZXNlcnZl4oCZPyBbLVdl
cnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPiAgICAgX190dG1fYm9fdW5yZXNl
cnZlKGJvKTsKPiAgICAgXn5+fn5+fn5+fn5+fn5+fn5+Cj4gICAgIHR0bV9ib191bnJlc2VydmUK
ClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQsIGdvaW5nIHRvIHJlc3Bpbi4KCkNocmlzdGlh
bi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
