From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2 2/3] drm/amdgpu: Allow dma_map_sg() coalescing
Date: Fri, 27 Apr 2018 12:20:33 -0400
Message-ID: <c2553d47-7932-3d07-d36a-1934cc78c180@codeaurora.org>
References: <c15119b9e8e18d96fbef6592fd7e827883c7bf59.1523977133.git.robin.murphy@arm.com>
 <622c9ac3784170880dbde6900146e68631df958a.1523977133.git.robin.murphy@arm.com>
 <59bb29d9-da0c-1542-88bf-71bed96f3ed2@codeaurora.org>
 <6338cb4f-6968-c657-212f-6bfd988f880c@codeaurora.org>
 <e6f7aef7-7515-a9c1-a411-2c8865415fc3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <e6f7aef7-7515-a9c1-a411-2c8865415fc3@arm.com>
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
To: Robin Murphy <robin.murphy@arm.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

T24gNC8yNy8yMDE4IDExOjU0IEFNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IEknbSB0YWtpbmcg
dGhpcyBiYWNrLiBJIG9ic2VydmVkIGEgY3Jhc2ggd2l0aCB0aGUgSFNBIGFwcGxpY2F0aW9uczoK
PiAKPiBGV0lXLCB3YXMgdGhpcyB3b3JraW5nIGJlZm9yZSwgb3IgaXMgdGhpcyBzb21ld2hlcmUg
bmV3IHRoYXQgd2UncmUgb25seSByZWFjaGluZyBub3cgdGhhdCBwaW5fdXNlcnBhZ2VzIGNhbiBz
dWNjZWVkPwoKWWVzLCBIU0EgYXBwbGljYXRpb24gaXMgYSBkaWZmZXJlbnQgdGVzdC4gUHJldmlv
dXMgRFJNIGxpYnJhcnkgdW5pdCB0ZXN0IGlzCnN0aWxsIHBhc3NpbmcuIEl0IG11c3QgaGF2ZSBz
b21lIHVuaXF1ZSBjaGFyYWN0ZXJpc3RpYy4gCgpJJ2xsIHRlc3QgeW91ciBwYXRjaCBhbmQgcmVw
b3J0LgoKLS0gClNpbmFuIEtheWEKUXVhbGNvbW0gRGF0YWNlbnRlciBUZWNobm9sb2dpZXMsIElu
Yy4gYXMgYW4gYWZmaWxpYXRlIG9mIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLgpRdWFsY29t
bSBUZWNobm9sb2dpZXMsIEluYy4gaXMgYSBtZW1iZXIgb2YgdGhlIENvZGUgQXVyb3JhIEZvcnVt
LCBhIExpbnV4IEZvdW5kYXRpb24gQ29sbGFib3JhdGl2ZSBQcm9qZWN0LgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
