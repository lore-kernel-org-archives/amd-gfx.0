From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 22/24] drm/amdkfd: Adding new IOCTL for scratch memory v2
Date: Mon, 21 Aug 2017 16:11:02 -0400
Message-ID: <9b600e94-f3d7-d1de-90da-6e578ce8c108@amd.com>
References: <1502852422-19620-1-git-send-email-Felix.Kuehling@amd.com>
 <1502852422-19620-23-git-send-email-Felix.Kuehling@amd.com>
 <20170821173918.GA4125@gmail.com>
 <CAFCwf10hhjmmoTv+3GP85FeyWYv4AyL1G+xBYmZfr_39N=wiOA@mail.gmail.com>
 <20170821200104.GB4125@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170821200104.GB4125-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Goz <ben.goz-5C7GfCeVMHo@public.gmane.org>, Moses Reuben <moses.reuben-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxNy0wOC0yMSAwNDowMSBQTSwgSmVyb21lIEdsaXNzZSB3cm90ZToKPj4gRnJvbSB0aGlz
IGV4cGxhbmF0aW9uLCBJIHRoaW5rIHRoYXQgdGhlIHVzZXIncyBzdXBwbGllZCBWQSBzaG91bGQg
YmUKPj4gdGVzdGVkIHRoYXQgaXRzIGEgdmFsaWQgd3JpdGFibGUgYXJlYSBvZiB0aGUgdXNlci4K
Pj4gSG93IGRvIHlvdSB0ZXN0IGZvciB0aGF0ID8gY291bGQgeW91IHBvaW50IG1lIHRvIHN1Y2gg
YSBjb2RlIGluIHRoZSBrZXJuZWwgPwo+PiBGcm9tIGxvb2tpbmcgYXQgb3RoZXIgZHJpdmVycyB0
aGF0IHBpbiBob3N0IG1lbW9yeSwgbGlrZSBtZWxsYW5veCBuaWMsCj4+IHRoZXkgZG9uJ3QgZG8g
YW55IHNwZWNpYWwgdGVzdGluZyBmb3IgdGhlIGFkZHJlc3MgdGhleSByZWNlaXZlIGZyb20KPj4g
dGhlIHVzZXIuCj4gR1VQIChnZXRfdXNlcl9wYWdlKCkpIHdpbGwgcGVyZm9ybSBwcm9wZXIgY2hl
Y2sgb24geW91ciBiZWhhbGYuCj4gSSBhbSBhc3N1bWluZyB0aG9zZSBkcml2ZXIgdXNlIEdVUC4K
Ck9uIEFQVXMsIHRoZSBHUFUgY2FuIGFkZHJlc3MgbWVtb3J5IGRpcmVjdGx5IHRocm91Z2ggQVRT
LiBTbyBpdCBkb2Vzbid0CnVzZSBHVVAuIFRoZSBHUFUgdXNlcyB0aGUgc2FtZSBwYWdlIHRhYmxl
cyBhcyB0aGUgQ1BVLCBzbyB1c2VzIHRoZSBzYW1lCmFjY2VzcyBiaXRzIHRvIGNoZWNrIHBlcm1p
c3Npb25zIG9uIHRoZSBmbHkuCgpPbiBkR1BVLCB3aGVuIHdlIHVzZSBWUkFNIGZvciBzY3JhdGNo
IGJhY2tpbmcsIHRoYXQgZG9lc24ndCB1c2UgR1VQLiBJbgp0aGVvcnkgaXQgc2hvdWxkIGJlIHBv
c3NpYmxlIHRvIHVzZSBHVVAgKHVzaW5nIG91ciB1c2VycHRyIG1lY2hhbmlzbSkuCkluIHRoYXQg
Y2FzZSBHVVAgd291bGQgY2hlY2sgdGhlIGFjY2VzcyBwZXJtaXNzaW9ucyBvZiB0aGUgdW5kZXJs
eWluZwptYXBwaW5nLgoKUmVnYXJkcywKICBGZWxpeAoKPgo+IErDqXLDtG1lCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
