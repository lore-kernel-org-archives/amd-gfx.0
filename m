From: Tom St Denis <tom.stdenis@amd.com>
Subject: Re: 'buf' pointer in ttm_bo_vm_access_kmap()
Date: Fri, 26 Jan 2018 09:40:27 -0500
Message-ID: <eb4c173e-69ea-991e-2263-a06c7ab23702@amd.com>
References: <d3f92e9e-d0aa-1861-df8b-78320be94483@amd.com>
 <b7b27f3c-8b8e-1ead-f00c-c118f86b71fc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <b7b27f3c-8b8e-1ead-f00c-c118f86b71fc@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: christian.koenig@amd.com
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjYvMDEvMTggMDk6MzggQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjYuMDEu
MjAxOCB1bSAxNTozMSBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4gSGkgYWxsLAo+Pgo+PiBJbiB0
aGUgZnVuY3Rpb24gdHRtX2JvX3ZtX2FjY2Vzc19rbWFwKCkgaXQgZG9lc24ndCBzZWVtIHRvIG1l
IGxpa2UgdGhlIAo+PiAnYnVmJyBwb2ludGVyIGlzIGluY3JlbWVudGVkLsKgIFRoYXQgc2VlbXMg
bGlrZSBhIGJ1ZyBubz8KPiAKPiBZZWFoLCBsb29rcyBzdXNwaWNpb3VzIHRvIG1lIGFzIHdlbGwu
IEJ1dCBUVE0gcXVlc3Rpb25zIHNob3VsZCBDQyB0aGUgCj4gZHJpIGxpc3QgYXMgd2VsbC4KPiAK
PiBBbmQgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UgSSB0aGluayBGZWxpeCB3YXMgdGhlIGF1dGhv
ciB0aGF0IGZ1bmN0aW9uLgo+IAoKSGkgQ2hyaXN0aWFuLAoKSSdtIGF1dGhvcmluZyBhIHNldCBv
ZiBtb3N0bHkgTkZDIHBhdGNoZXMgZm9yIFRUTSBhbmQgYWxyZWFkeSBjcmFmdGVkIGEgCmZpeCBm
b3IgdGhpcyBpbiB0aGUgcHJvY2Vzcy4KCklmIHRoZSBmaXggKHdoaWNoIGlzIGxpdGVyYWxseSAi
YnVmICs9IGJ5dGVzIiBhdCB0aGUgZW5kIG9mIHRoZSB3aGlsZSAKbG9vcCkgZG9lc24ndCBnZXQg
TkFLJ2VkIEknbGwgc3VibWl0IGl0IGFzIHBhcnQgb2YgbXkgY2xlYW51cCBwYXRjaGVzLgoKQ2hl
ZXJzLApUb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
