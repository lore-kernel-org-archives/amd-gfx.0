From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Add support for XGMI hive reset
Date: Wed, 28 Nov 2018 16:14:13 +0100
Message-ID: <34748cbb-1760-6037-98b9-d39f1824bfa5@gmail.com>
References: <1543343848-11249-1-git-send-email-andrey.grodzovsky@amd.com>
 <f68ac17d-657d-81fb-42a5-54dfb8cbbd35@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f68ac17d-657d-81fb-42a5-54dfb8cbbd35-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

IEZyb20gdGhlIGRlc2lnbiBpdCBsb29rcyBnb29kIHRvIG1lLCBidXQgSSByZWFsbHkgZG9uJ3Qg
a25vdyBtdWNoIGFib3V0IApYR01JLgoKV2hlbiB5b3Ugd2FudCB0byBzaW1wbGlmeSBpdCBhIGJp
dCwgSSdtIHByZXR0eSBzdXJlIHRoZSBjYWxscyB0byAKdHRtX2JvX2xvY2tfZGVsYXllZF93b3Jr
cXVldWUoKS90dG1fYm9fdW5sb2NrX2RlbGF5ZWRfd29ya3F1ZXVlKCkgY2FuIApqdXN0IGJlIGRy
b3BwZWQuCgpUaGV5IGFyZSBjb3B5ICYgcGFzdGVkIG92ZXIgZnJvbSByYWRlb24gYW5kIG9uIGFt
ZGdwdSB0aGVyZSBpc24ndCBhbnkgCnJlYXNvbiBmb3IgdGhhdCBhbnkgbW9yZS4KCkNocmlzdGlh
bi4KCkFtIDI4LjExLjE4IHVtIDE2OjA3IHNjaHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Ogo+IFBp
bmcuLi4KPgo+IEFuZHJleQo+Cj4KPiBPbiAxMS8yNy8yMDE4IDAxOjM3IFBNLCBBbmRyZXkgR3Jv
ZHpvdnNreSB3cm90ZToKPj4gVGhpcyBzZXQgb2YgcGF0Y2hlcyBhZGRzIHN1cHBvcnQgdG8gcmVz
ZXQgZW50aXJlIFhHTUkgaGl2ZQo+PiB3aGVuIHJlc2V0IGlzIHJlcXVpcmVkLgo+Pgo+PiBQYXRj
aGVzIDEtMiByZWZhY3RvcmluZyBhIGJpdCB0aGUgWEdNSSBpbmZyYXN0cnVjdHVyZSBhcwo+PiBw
cmVwYXJhdG9uIGZvciB0aGUgYWN0dWFsIGhpdmUgcmVzZXQgY2hhbmdlLgo+Pgo+PiBQYXRjaCA1
IGlzIEdQVSByZXNldC9yZWNvdmVyeSByZWZhY3RvcmVkIHRvIHN1cHBvcnQgWEdNSQo+PiBoaXZl
IHJlc2V0Lgo+Pgo+PiBBbmRyZXkgR3JvZHpvdnNreSAoMyk6Cj4+ICAgICBkcm0vYW1kZ3B1OiBS
ZWZhY3RvciBhbWRncHVfeGdtaV9hZGRfZGV2aWNlIHYzCj4+ICAgICBkcm0vYW1kZ3B1OiBFeHBv
c2UgaGl2ZSBhZGV2IGxpc3QgYW5kIHhnbWlfbXV0ZXggdjMKPj4gICAgIGRybS9hbWRncHU6IFJl
ZmFjdG9yIEdQVSByZXNldCBmb3IgWEdNSSBoaXZlIGNhc2UgdjMKPj4KPj4gICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAgIHwgICA5ICstCj4+ICAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDM3NiArKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdt
aS5jICAgfCAgNjggKysrLS0tCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV94Z21pLmggICB8ICAzOSArKysKPj4gICAgNCBmaWxlcyBjaGFuZ2VkLCAzNDMgaW5zZXJ0aW9u
cygrKSwgMTQ5IGRlbGV0aW9ucygtKQo+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaAo+Pgo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
