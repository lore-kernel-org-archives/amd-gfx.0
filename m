From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Date: Wed, 30 Oct 2019 15:50:43 +0100
Message-ID: <d73c46e2-ed85-f56e-3a2a-cbf2919d0a3f@gmail.com>
References: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
 <23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com>
 <f3be329d-d350-c821-00b7-d94858335796@amd.com>
 <d573688c-0997-1928-0c56-b60a29ff7fde@gmail.com>
 <b5e99dc3-5658-7e48-63f7-bf9533f582f8@amd.com>
 <2505c476-9e10-f70e-355c-33765a37d607@amd.com>
 <a1c31f37-128f-51b1-f747-fe75d78d4214@amd.com>
 <a9789f76-3ba5-ad71-1507-5eac6f589b82@amd.com>
 <971115b1-6208-1dd5-d99f-c9377663a80b@amd.com>
 <2e2ebf73-9a25-5ad2-78e7-07c8b1db1b37@amd.com>
 <08e3c44f-5d08-d5f5-bc76-ea9b77032e5a@amd.com>
 <1e1d0b06-75ab-160c-a6c7-baede02f1e7d@amd.com>
 <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QSBsb2NrIGluc2lkZSB0aGUgc2NoZWR1bGVyIGlzIHJhdGhlciB0cmlja3kgdG8gaW1wbGVtZW50
LgoKV2hhdCB5b3UgbmVlZCB0byBkbyBpcyB0byBnZXQgcmlkIG9mIHRoZSBwYXJrKCkvdW5wYXJr
KCkgaGFjayBpbiAKZHJtX3NjaGVkX2VudGl0eV9maW5pKCkuCgpXZSBjb3VsZCBkbyB0aGlzIHdp
dGggYSBzdHJ1Y3QgY29tcGxldGlvbiBvciBjb252ZXJ0IHRoZSBzY2hlZHVsZXIgZnJvbSAKYSB0
aHJlYWQgdG8gYSB3b3JrIGl0ZW0uCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAzMC4xMC4xOSB1
bSAxNTo0NCBzY2hyaWViIEdyb2R6b3Zza3ksIEFuZHJleToKPiBUaGF0IGdvb2TCoCBhcyBwcm9v
ZiBvZiBSQ0EgYnV0IEkgc3RpbGwgdGhpbmsgd2Ugc2hvdWxkIGdyYWIgYSBkZWRpY2F0ZWQKPiBs
b2NrIGluc2lkZSBzY2hlZHVsZXIgc2luY2UgdGhlIHJhY2UgaXMgaW50ZXJuYWwgdG8gc2NoZWR1
bGVyIGNvZGUgc28KPiB0aGlzIGJldHRlciB0byBoYW5kbGUgaXQgaW5zaWRlIHRoZSBzY2hlZHVs
ZXIgY29kZSB0byBtYWtlIHRoZSBmaXggYXBwbHkKPiBmb3IgYWxsIGRyaXZlcnMgdXNpbmcgaXQu
Cj4KPiBBbmRyZXkKPgo+IE9uIDEwLzMwLzE5IDQ6NDQgQU0sIFMsIFNoaXJpc2ggd3JvdGU6Cj4+
Pj4+IFdlIHN0aWxsIGhhdmUgaXQgYW5kIGlzbid0IGRvaW5nIGt0aHJlYWRfcGFyaygpL3VucGFy
aygpIGZyb20KPj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9maW5pIHdoaWxlIEdQVSByZXNldCBpbiBw
cm9ncmVzcyBkZWZlYXRzIGFsbCB0aGUKPj4+Pj4gcHVycG9zZSBvZiBkcm1fc2NoZWRfc3RvcC0+
a3RocmVhZF9wYXJrID8gSWYKPj4+Pj4gZHJtX3NjaGVkX2VudGl0eV9maW5pLT4ga3RocmVhZF91
bnBhcmsgaGFwcGVucyBBRlRFUgo+Pj4+PiBkcm1fc2NoZWRfc3RvcC0+a3RocmVhZF9wYXJrIG5v
dGhpbmcgcHJldmVudHMgZnJvbSBhbm90aGVyICh0aGlyZCkKPj4+Pj4gdGhyZWFkIGtlZXAgc3Vi
bWl0dGluZyBqb2IgdG8gSFcgd2hpY2ggd2lsbCBiZSBwaWNrZWQgdXAgYnkgdGhlCj4+Pj4+IHVu
cGFya2VkIHNjaGVkdWxlciB0aHJlYWQgdHJ5IHRvIHN1Ym1pdCB0byBIVyBidXQgZmFpbCBiZWNh
dXNlIHRoZQo+Pj4+PiBIVyByaW5nIGlzIGRlYWN0aXZhdGVkLgo+Pj4+Pgo+Pj4+PiBJZiBzbyBt
YXliZSB3ZSBzaG91bGQgc2VyaWFsaXplIGNhbGxzIHRvCj4+Pj4+IGt0aHJlYWRfcGFyay91bnBh
cmsoc2NoZWQtPnRocmVhZCkgPwo+Pj4+Pgo+Pj4+IFllYWgsIHRoYXQgd2FzIG15IHRoaW5raW5n
IGFzIHdlbGwuIFByb2JhYmx5IGJlc3QgdG8ganVzdCBncmFiIHRoZQo+Pj4+IHJlc2V0IGxvY2sg
YmVmb3JlIGNhbGxpbmcgZHJtX3NjaGVkX2VudGl0eV9maW5pKCkuCj4+Pgo+Pj4gU2hpcmlzaCAt
IHBsZWFzZSB0cnkgbG9ja2luZyAmYWRldi0+bG9ja19yZXNldCBhcm91bmQgY2FsbHMgdG8KPj4+
IGRybV9zY2hlZF9lbnRpdHlfZmluaSBhcyBDaHJpc3RpYW4gc3VnZ2VzdHMgYW5kIHNlZSBpZiB0
aGlzIGFjdHVhbGx5Cj4+PiBoZWxwcyB0aGUgaXNzdWUuCj4+Pgo+PiBZZXMgdGhhdCBhbHNvIHdv
cmtzLgo+Pgo+PiBSZWdhcmRzLAo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
