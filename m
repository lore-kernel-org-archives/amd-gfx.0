From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use ttm pool first
Date: Wed, 24 Jan 2018 11:52:38 +0100
Message-ID: <291e091d-529b-1ec8-55fc-c53b627c8423@gmail.com>
References: <20180124091707.32059-1-david1.zhou@amd.com>
 <36db7c3c-aa12-d11f-ef5d-63fc40c395ba@amd.com>
 <e93a1953-cfc2-f4f4-7ae5-4bc28cfb44e5@amd.com>
 <35b80a48-17bc-d608-ab69-6ac8608b7730@amd.com>
 <77f05a88-6201-b075-ef29-3c5907dc3f8f@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <77f05a88-6201-b075-ef29-3c5907dc3f8f-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org

QW0gMjQuMDEuMjAxOCB1bSAxMTozMiBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gT24gMjAxOOW5
tDAx5pyIMjTml6UgMTc6NDksIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFtTTklQXQo+PiBO
b3BlLCBhcyBJIHdyb3RlIHRoYXQgd29uJ3Qgd29yay4gWW91IG11c3QgaW1wcm92ZSB0aGUgZGV0
ZWN0aW9uIGlmIAo+PiB3ZSBuZWVkIGNvaGVyZW50IG9yIG5vdCBjb2hlcmVudCBhbGxvY2F0aW9u
Lgo+IEJ1dCBob3cgdG8gZGlmZmVyZW50aWF0ZSBjb2hlcmVudCBvciBub3QgY29oZXJlbnQgYWxs
b2NhdGlvbj8gY2hlY2sgaWYgCj4gbWF4IGlvIGFkZHJlc3Mgb2Ygc3lzdGVtIG1lbW9yeSB1bmRl
ciA0MGJpdHMgcGNpZSBhZGRyZXNzIHNwYWNlPyBEbyAKPiB5b3Uga25vdyBob3cgdG8gZ2V0IHRo
ZSBtYXggaW8gYWRkcmVzcyBvZiBzeXN0ZW0gbWVtb3J5PwoKV2VsbCB0aGF0IGlzIGEgZ29vZCBx
dWVzdGlvbiwgd2hpY2ggbm9ib2R5IGhhZCBhbiBhbnN3ZXIgZm9yIHNvIGZhciAoYW5kIAphIGNv
dXBsZSBvZiBwZW9wbGUgYWxyZWFkeSBsb29rZWQgaW50byBpdCkuCgpXZSBjb3VsZCBzdGFydCBi
eSBjaGVja2luZyBpZiBtYXhfcGZuIGlzIDw9IHRoZSA0MGJpdHMgbGltaXQgb3IgaWYgSU9NTVUg
CmlzIGVuYWJsZWQgaW5zdGVhZCBvZiBTV0lPVExCLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
