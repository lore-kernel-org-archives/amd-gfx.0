From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/6] drm/amdgpu/psp: Do not load asd for SRIOV
Date: Fri, 5 May 2017 14:46:50 +0800
Message-ID: <20170505064649.GA32651@hr-amur2>
References: <1493879795-27012-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493879795-27012-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Cc: Daniel Wang <Daniel.Wang2-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVGh1LCBNYXkgMDQsIDIwMTcgYXQgMDI6MzY6MzVQTSArMDgwMCwgWGlhbmdsaWFuZyBZdSB3
cm90ZToKPiBJZiBwc3AgdmVyc2lvbiBkb2Vzbid0IG1hdGNoIGFzZCB2ZXJzaW9uLCBhc2QgbG9h
ZGluZyB3aWxsIGJlCj4gZmFpbGVkLiBBZGQgd29ya2Fyb3VuZCB0byBieXBhc3MgaXQgZm9yIHNy
aW92Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYW5nIDxEYW5pZWwuV2FuZzJAYW1kLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBYaWFuZ2xpYW5nIFl1IDxYaWFuZ2xpYW5nLll1QGFtZC5jb20+
Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDcgKysr
KysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+IGluZGV4IGFjNWU5MmUuLjUwNDEwNzMgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCj4gQEAgLTIzMCw2ICsyMzAs
MTMgQEAgc3RhdGljIGludCBwc3BfYXNkX2xvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4g
IAlpbnQgcmV0Owo+ICAJc3RydWN0IHBzcF9nZnhfY21kX3Jlc3AgKmNtZDsKPiAgCj4gKwkvKiBJ
ZiBQU1AgdmVyc2lvbiBkb2Vzbid0IG1hdGNoIEFTRCB2ZXJzaW9uLCBhc2QgbG9hZGluZyB3aWxs
IGJlIGZhaWxlZC4KPiArCSAqIGFkZCB3b3JrYXJvdW5kIHRvIGJ5cGFzcyBpdCBmb3Igc3Jpb3Yg
bm93Lgo+ICsJICogVE9ETzogYWRkIHZlcnNpb24gY2hlY2sgdG8gbWFrZSBpdCBjb21tb24KPiAr
CSAqLwoKV2hpY2ggcHNwIHZlcnNpb24/IEZpcm13YXJlIG9yIGJvb3QgbG9hZGVyPyBDYW4geW91
IGV4cGxhaW4gY2xlYXI/CgpUaGFua3MsClJ1aQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
