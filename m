From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Use ARRAY_SIZE macro in
 kfd_build_sysfs_node_entry
Date: Fri, 19 Jan 2018 17:18:23 -0500
Message-ID: <1fea2528-11a5-0210-6350-e916ebfebbdf@amd.com>
References: <20180119003955.GA28885@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180119003955.GA28885-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
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
To: "Gustavo A. R. Silva" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

TG9va3MgZ29vZC4gVGhpcyBjaGFuZ2UgaXMgUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nCjxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKUmVnYXJkcywKwqAgRmVsaXgKCgpPbiAyMDE4LTAxLTE4
IDA3OjM5IFBNLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOgo+IFVzZSBBUlJBWV9TSVpFIGlu
c3RlYWQgb2YgZGl2aWRpbmcgc2l6ZW9mIGFycmF5IHdpdGggc2l6ZW9mIGFuIGVsZW1lbnQuCj4K
PiBUaGlzIGlzc3VlIHdhcyBkZXRlY3RlZCB3aXRoIHRoZSBoZWxwIG9mIENvY2NpbmVsbGUuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxnYXJzaWx2YUBlbWJlZGRlZG9y
LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMg
fCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPiBpbmRleCBjNmE3
NjA5Li43NzgzMjUwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF90b3BvbG9neS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9s
b2d5LmMKPiBAQCAtNjc3LDcgKzY3Nyw3IEBAIHN0YXRpYyBpbnQga2ZkX2J1aWxkX3N5c2ZzX25v
ZGVfZW50cnkoc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmRldiwKPiAgCX0KPiAgCj4gIAkv
KiBBbGwgaGFyZHdhcmUgYmxvY2tzIGhhdmUgdGhlIHNhbWUgbnVtYmVyIG9mIGF0dHJpYnV0ZXMu
ICovCj4gLQludW1fYXR0cnMgPSBzaXplb2YocGVyZl9hdHRyX2lvbW11KS9zaXplb2Yoc3RydWN0
IGtmZF9wZXJmX2F0dHIpOwo+ICsJbnVtX2F0dHJzID0gQVJSQVlfU0laRShwZXJmX2F0dHJfaW9t
bXUpOwo+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShwZXJmLCAmZGV2LT5wZXJmX3Byb3BzLCBsaXN0
KSB7Cj4gIAkJcGVyZi0+YXR0cl9ncm91cCA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBrZmRfcGVy
Zl9hdHRyKQo+ICAJCQkqIG51bV9hdHRycyArIHNpemVvZihzdHJ1Y3QgYXR0cmlidXRlX2dyb3Vw
KSwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
