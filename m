From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function v3
Date: Wed, 21 Feb 2018 21:10:28 +0000
Message-ID: <CACvgo50rWD737JhfR=7sH3bVUwR3FdWN9bve7yZ2zxGHHuBFgQ@mail.gmail.com>
References: <20180220125829.27060-1-christian.koenig@amd.com>
 <20180220131253.GF25314@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180220131253.GF25314-Nxj+rRp3nVydTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
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
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gMjAgRmVicnVhcnkgMjAxOCBhdCAxMzoxMiwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToKPiBPbiBUdWUsIEZlYiAyMCwgMjAxOCBhdCAwMTo1ODoyNlBNICsw
MTAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBhbWRncHUgbmVlZHMgdG8gdmVyaWZ5IGlm
IHVzZXJzcGFjZSBzZW5kcyB1cyB2YWxpZCBhZGRyZXNzZXMgYW5kIHRoZSBzaW1wbGVzdAo+PiB3
YXkgb2YgZG9pbmcgdGhpcyBpcyB0byBjaGVjayBpZiB0aGUgYnVmZmVyIG9iamVjdCBpcyBsb2Nr
ZWQgd2l0aCB0aGUgdGlja2V0Cj4+IG9mIHRoZSBjdXJyZW50IHN1Ym1pc3Npb24uCj4+Cj4+IENs
ZWFuIHVwIHRoZSBhY2Nlc3MgdG8gdGhlIHd3X211dGV4IGludGVybmFscyBieSBwcm92aWRpbmcg
YSBmdW5jdGlvbgo+PiBmb3IgdGhpcyBhbmQgZXh0ZW5kIHRoZSBjaGVjayB0byB0aGUgdGhyZWFk
IG93bmluZyB0aGUgdW5kZXJseWluZyBtdXRleC4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiBNdWNoIHRoYW5rcyBmb3Ig
Q2MnaW5nIHRoZSByZWxldmFudCBtYWludGFpbmVycyA6Lwo+CkRvdWJ0IGl0J3MgaW50ZW50aW9u
YWwuIFRoZSBnZXQtbWFpbnRhaW5lciBzY3JpcHQgc2VlbXMgY29uZnVzZWQgYW5kCmxpc3RzIG5v
IG1haW50YWluZXJzPwoKJCAuL3NjcmlwdHMvZ2V0X21haW50YWluZXIucGwgaW5jbHVkZS9saW51
eC93d19tdXRleC5oCmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlzdCkKCldo
aWxlIHRoZSBub3JtYWwgbXV0ZXggaGVhZGVyIHdvcmtzIGZpbmUuCgokIC4vc2NyaXB0cy9nZXRf
bWFpbnRhaW5lci5wbCBpbmNsdWRlL2xpbnV4L211dGV4LmgKUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPiAobWFpbnRhaW5lcjpMT0NLSU5HIFBSSU1JVElWRVMpCkluZ28gTW9s
bmFyIDxtaW5nb0ByZWRoYXQuY29tPiAobWFpbnRhaW5lcjpMT0NLSU5HIFBSSU1JVElWRVMpCmxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlzdDpMT0NLSU5HIFBSSU1JVElWRVMp
CgpIVEgKRW1pbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
