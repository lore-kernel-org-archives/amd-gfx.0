From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] amdkfd: always select MMU_NOTIFIER
Date: Wed, 28 Mar 2018 18:04:33 +0200
Message-ID: <664e2827-5237-160b-6ecf-c2da163569e1@amd.com>
References: <20180328155340.2253343-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180328155340.2253343-1-arnd-r2nGTMty4D4@public.gmane.org>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Cc: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMjguMDMuMjAxOCB1bSAxNzo1MyBzY2hyaWViIEFybmQgQmVyZ21hbm46Cj4gQnVpbGRpbmcg
YW1ka2ZkIHdpdGhvdXQgTU1VIG5vdGlmaWVycyBpcyBicm9rZW46Cj4KPiBJbiBmaWxlIGluY2x1
ZGVkIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3ZpLmM6
Mjg6Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaDo1ODQ6MjI6IGVycm9y
OiBmaWVsZCAnbW11X25vdGlmaWVyJyBoYXMgaW5jb21wbGV0ZSB0eXBlCj4KPiBUaGlzIGFkZHMg
dGhlIG1pc3NpbmcgJ3NlbGVjdCBNTVVfTk9USUZJRVInIGxpbmUgdG8gbWFrZSBpdCBidWlsZAo+
IGNsZWFubHkgYWxsIHRoZSB0aW1lLgo+Cj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+LCBidXQgSSB3b3VsZCB3YWl0IApvbiB3aGF0IEZlbGl4IHNheXMgdG8gdGhh
dC4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnIHwgMSArCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
S2NvbmZpZwo+IGluZGV4IGVkMmYwNmM5ZjM0Ni4uNWEyNmFjYjkwZTE5IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9LY29uZmlnCj4gQEAgLTQsNiArNCw3IEBACj4gICAKPiAgIGNvbmZpZyBI
U0FfQU1ECj4gICAJdHJpc3RhdGUgIkhTQSBrZXJuZWwgZHJpdmVyIGZvciBBTUQgR1BVIGRldmlj
ZXMiCj4gKwlzZWxlY3QgTU1VX05PVElGSUVSCj4gICAJZGVwZW5kcyBvbiBEUk1fQU1ER1BVICYm
IFg4Nl82NAo+ICAgCWltcGx5IEFNRF9JT01NVV9WMgo+ICAgCWhlbHAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
