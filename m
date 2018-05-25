From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer dereference when run App
 with DRI_PRIME=1
Date: Fri, 25 May 2018 13:23:25 +0200
Message-ID: <31572675-9d62-2acf-5cbf-7a389ac87554@gmail.com>
References: <1527226896-29270-1-git-send-email-Jerry.Zhang@amd.com>
 <f9495673-cb9a-cd75-a569-c4eb5b2e0c63@gmail.com> <5B07B933.4060701@amd.com>
 <2a876b66-abaa-5ca0-5975-2b458ab9dba5@amd.com> <5B07C807.4050806@amd.com>
 <98ef8cf3-31bf-229b-fee2-88f426e3a91f@amd.com> <5B07DCAA.509@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5B07DCAA.509-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjUuMDUuMjAxOCB1bSAxMTo1MSBzY2hyaWViIFpoYW5nLCBKZXJyeSAoSnVud2VpKToKPiBP
biAwNS8yNS8yMDE4IDA1OjM1IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyNS4w
NS4yMDE4IHVtIDEwOjIzIHNjaHJpZWIgWmhhbmcsIEplcnJ5IChKdW53ZWkpOgo+Pj4gT24gMDUv
MjUvMjAxOCAwMzo1NCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBBbSAyNS4wNS4y
MDE4IHVtIDA5OjIwIHNjaHJpZWIgWmhhbmcsIEplcnJ5IChKdW53ZWkpOgo+Pj4+PiBPbiAwNS8y
NS8yMDE4IDAyOjQ0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+Pj4gTkFLLCB0aGF0
IHByb2JhYmx5IGp1c3QgZml4ZWQgdGhlIHN5bXB0b20gYnV0IG5vdCB0aGUgdW5kZXJseWluZyAK
Pj4+Pj4+IHByb2JsZW0uCj4+Pj4+Pgo+Pj4+Pj4gU29tZWJvZHkgaXMgYWNjZXNzaW5nIHRoZSBw
YWdlIGFycmF5IHdoZW4gaXQgc2hvdWxkIG5ldmVyIGJlIAo+Pj4+Pj4gYWNjZXNzZWQuCj4+Pj4+
Cj4+Pj4+IElmIHByaW1lIGltcG9ydCBhcyBHVFQgYm8gYnkgZGVmYXVsdChub3cgaXQncyBDUFUg
Ym8pLCBpdCB3b3VsZCAKPj4+Pj4gaGFwcGVucwo+Pj4+PiBxdWlja2x5IHdoZW4gR1RUIHNnIGJv
IGNyZWF0aW9uIHJhdGhlciB0aGFuIG5leHQgY3MgdmFsaWRhdGlvbi4KPj4+Pj4KPj4+Pj4gU2lu
Y2UgdHRtX3NnX3R0X2luaXQoKSBvbmx5IGFsbG9jYXRlcyBndHQtPnR0bS5kbWFfYWRkcmVzcyBp
ZiBzZyAKPj4+Pj4gYm8gaXMKPj4+Pj4gY3JlYXRlZCwgaXQgd291bGQgZmFpbCB0byBhY2Nlc3Mg
dHRtLT5wYWdlcyB3aGVuIHR0bSBwb3B1bGF0ZS4KPj4+Pgo+Pj4+IEFuZCBleGFjdGx5IHRoYXQn
cyB0aGUgcHJvYmxlbSwgYW5kIGltcG9ydGVkIEJPIHNob3VsZCBuZXZlciBwb3B1bGF0ZS4KPj4+
Pgo+Pj4+Pgo+Pj4+PiBjdXJyZW50IGVycm9yIGhhcHBlbnMgaW4gdHRtIHBvcHVsYXRlIGZyb20g
Y3MgdmFsaWRhdGlvbiwgdGhlIHNnIAo+Pj4+PiBibyBpcwo+Pj4+PiBpbXBvcnRlZCBmcm9tIGV4
cG9ydGVyLgo+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IEhvdyBkaWQgeW91IG1hbmFnZSB0byB0cmlnZ2Vy
IHRoaXM/Cj4+Pj4+Cj4+Pj4+IFBSSV9QUklNRT0xIHdpdGggVW5pZ2luZSBoZWF2ZW4uCj4+Pj4K
Pj4+PiBHb2luZyB0byBnaXZlIHRoYXQgYSB0cnksIGJ1dCB0aGUgbGFzdCB0aW1lIEkgY2hlY2sg
dGhhdCB3b3JrZWQgYXMgCj4+Pj4gZXhwZWN0ZWQuCj4+Pgo+Pj4gRllJLgo+Pj4gUFJJX1BSSU1F
PTEgZ2x4aW5mbyB3aWxsIG5vdCB0cmlnZ2VyIHRoYXQsIGJ1dCB0aGUgZ2FtZSBkb2VzLgo+Pgo+
PiBKdXN0IHRlc3RlZCBhbmQgaXQgd29ya3MgcGVyZmVjdGx5IGZpbmUuCj4+Cj4+IElzIHRoYXQg
b24gdGhlIGNsb3NlZCBzdGFjayBvciB0aGUgb3BlbiBzdGFjaz8KPgo+IEkgdXNlZCB1bmlmaWVk
IGRyaXZlcihsYXRlc3QgMTguMjAgYnVpbGQpICsgZHJtLW5leHQga2VybmVsLCBpbnN0YWxsZWQg
Cj4gYXMgYWxsIG9wZW4gc3RhY2sgb24gQStBIHBsYXRmb3JtLgo+IChpc3N1ZSB3YXMgZm91bmQg
YnkgMTguMjAgYnVpbGQsIGFsbCBvcGVuIHN0YWNrKGRrbXMgZHJpdmVyKSkKPgo+IEJUVywgSG93
IGRpZCB5b3UgZ2V0IHRoZSBVTUQ/IGFwdC1nZXQgb3IgYnVpbGQgYnkgeW91cnNlbGY/CgpUaGF0
J3Mgc2VsZiBidWlsZCBNZXNhK2xpYmRybS4KCkRvIHlvdSBoYXZlIHRoZSBhcHQgdXJsIGFuZC9v
ciBwYWNrYWdlIHZlcnNpb25zIGF0IGhhbmQgeW91IHVzZWQgZm9yIHRoZSAKdGVzdD8KCkNocmlz
dGlhbi4KCj4KPgo+IEplcnJ5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
