From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add VCN JPEG support amdgpu_ctx_num_entities
Date: Fri, 30 Nov 2018 10:10:54 +0100
Message-ID: <32b08146-d307-6f1f-e8ad-604a8c496cb2@gmail.com>
References: <20181130020036.1732-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181130020036.1732-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMzAuMTEuMTggdW0gMDM6MDAgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gTG9va3MgbGlrZSBp
dCB3YXMgbWlzc2VkIHdoZW4gc2V0dGluZyBzdXBwb3J0IHdhcyBhZGRlZC4KPgo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+
Cj4gVGhpcyBpcyBhIGxlZ2l0IGJ1ZyBmaXguICB0aGUgcmVzdCBvZiB0aGlzIHNlcmllcyBuZWVk
cyBtb3JlIHdvcmsuCj4KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMg
fCAxICsKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+IGluZGV4IGY5YjU0MjM2MTAyZC4uOTVmNGM0MTM5
ZmM2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHgu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwo+IEBAIC0z
OSw2ICszOSw3IEBAIGNvbnN0IHVuc2lnbmVkIGludCBhbWRncHVfY3R4X251bV9lbnRpdGllc1tB
TURHUFVfSFdfSVBfTlVNXSA9IHsKPiAgIAlbQU1ER1BVX0hXX0lQX1VWRF9FTkNdCT0JMSwKPiAg
IAlbQU1ER1BVX0hXX0lQX1ZDTl9ERUNdCT0JMSwKPiAgIAlbQU1ER1BVX0hXX0lQX1ZDTl9FTkNd
CT0JMSwKPiArCVtBTURHUFVfSFdfSVBfVkNOX0pQRUddCT0JMSwKPiAgIH07Cj4gICAKPiAgIHN0
YXRpYyBpbnQgYW1kZ3B1dF9jdHhfdG90YWxfbnVtX2VudGl0aWVzKHZvaWQpCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
