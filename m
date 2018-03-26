From: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] drm/amd/pp: silence a static checker warning
Date: Mon, 26 Mar 2018 11:30:25 +0800
Message-ID: <20180326033024.GC27239@hr-amur2>
References: <20180323113903.GD28518@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180323113903.GD28518@mwanda>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Tom St Denis <tom.stdenis@amd.com>, David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Christian =?utf-8?B?S++/vW5pZw==?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gRnJpLCBNYXIgMjMsIDIwMTggYXQgMDI6Mzk6MDNQTSArMDMwMCwgRGFuIENhcnBlbnRlciB3
cm90ZToKPiBUaGlzIGhhcyBhIHN0YXRpYyBjaGVja2VyIHdhcm5pbmcgYmVjYXVzZSAiZnJldiIg
YW5kICJjcmV2IiBjYW4gYmUKPiB1bmluaXRpYWxpemVkIGlmICJpbmZvIiBpcyBOVUxMLiAgSSBq
dXN0IGNoYW5nZWQgdGhlIG9yZGVyIG9mIHRoZSBjaGVja3MKPiBzbyB0aGF0IHdlIGNoZWNrICJp
bmZvIiBmaXJzdC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVu
dGVyQG9yYWNsZS5jb20+CgpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNv
bT4KCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdy
L3NtdThfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdThf
aHdtZ3IuYwo+IGluZGV4IDc1YTQ2NWY3NzFmMC4uN2IyNjYwN2M2NDZhIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3IuYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3IuYwo+IEBAIC0z
MTksMTMgKzMxOSwxMyBAQCBzdGF0aWMgaW50IHNtdThfZ2V0X3N5c3RlbV9pbmZvX2RhdGEoc3Ry
dWN0IHBwX2h3bWdyICpod21ncikKPiAgCQkJR2V0SW5kZXhJbnRvTWFzdGVyVGFibGUoREFUQSwg
SW50ZWdyYXRlZFN5c3RlbUluZm8pLAo+ICAJCQkmc2l6ZSwgJmZyZXYsICZjcmV2KTsKPiAgCj4g
LQlpZiAoY3JldiAhPSA5KSB7Cj4gLQkJcHJfZXJyKCJVbnN1cHBvcnRlZCBJR1AgdGFibGU6ICVk
ICVkXG4iLCBmcmV2LCBjcmV2KTsKPiArCWlmIChpbmZvID09IE5VTEwpIHsKPiArCQlwcl9lcnIo
IkNvdWxkIG5vdCByZXRyaWV2ZSB0aGUgSW50ZWdyYXRlZCBTeXN0ZW0gSW5mbyBUYWJsZSFcbiIp
Owo+ICAJCXJldHVybiAtRUlOVkFMOwo+ICAJfQo+ICAKPiAtCWlmIChpbmZvID09IE5VTEwpIHsK
PiAtCQlwcl9lcnIoIkNvdWxkIG5vdCByZXRyaWV2ZSB0aGUgSW50ZWdyYXRlZCBTeXN0ZW0gSW5m
byBUYWJsZSFcbiIpOwo+ICsJaWYgKGNyZXYgIT0gOSkgewo+ICsJCXByX2VycigiVW5zdXBwb3J0
ZWQgSUdQIHRhYmxlOiAlZCAlZFxuIiwgZnJldiwgY3Jldik7Cj4gIAkJcmV0dXJuIC1FSU5WQUw7
Cj4gIAl9Cj4gIAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
