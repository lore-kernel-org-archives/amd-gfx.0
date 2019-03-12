From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/v3d: Fix calling drm_sched_resubmit_jobs for same
 sched.
Date: Tue, 12 Mar 2019 17:48:02 +0000
Message-ID: <CY4PR12MB1446C0DAFA3349227DEB9B0AEA490@CY4PR12MB1446.namprd12.prod.outlook.com>
References: <1552409822-17230-1-git-send-email-andrey.grodzovsky@amd.com>,
 <87imworo9v.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <87imworo9v.fsf-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Content-Language: en-GB
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
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org" <tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org>

VGhleSBhcmUgbm90IHRoZSBzYW1lLCBidXQgdGhlIGd1aWx0eSBqb2IgYmVsb25ncyB0byBvbmx5
IG9uZSB7ZW50aXR5LCBzY2hlZHVsZXJ9IHBhaXIgYW5kIHNvIHdlIG1hcmsgYXMgZ3VpbHR5IG9u
bHkgZm9yIHRoYXQgcGFydGljdWxhciBlbnRpdHkgaW4gdGhlIGNvbnRleHQgb2YgdGhhdCBzY2hl
ZHVsZXIgb25seSBvbmNlLgoKQW5kcmV5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkZyb206IEVyaWMgQW5ob2x0IDxlcmljQGFuaG9sdC5uZXQ+ClNlbnQ6IDEyIE1h
cmNoIDIwMTkgMTM6MzM6MTYKVG86IEdyb2R6b3Zza3ksIEFuZHJleTsgZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IHRvbWV1QHRv
bWV1dml6b3NvLm5ldApDYzogR3JvZHpvdnNreSwgQW5kcmV5ClN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS92M2Q6IEZpeCBjYWxsaW5nIGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzIGZvciBzYW1lIHNj
aGVkLgoKQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+IHdyaXRl
czoKCj4gQWxzbyBzdG9wIGNhbGxpbmcgZHJtX3NjaGVkX2luY3JlYXNlX2thcm1hIG11bHRpcGxl
IHRpbWVzLgoKRWFjaCB2M2QtPnF1ZXVlW3FdLnNjaGVkIHdhcyBpbml0aWFsaXplZCB3aXRoIGEg
c2VwYXJhdGUKZHJtX3NjaGVkX2luaXQoKS4gIEkgd291bGRuJ3QgaGF2ZSB0aG91Z2h0IHRoZXkg
d2VyZSBhbGwgdGhlICJzYW1lCnNjaGVkIi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
