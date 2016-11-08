From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 1/2] dma-buf: return index of the first signaled fence (v2)
Date: Wed, 9 Nov 2016 01:04:18 +0530
Message-ID: <CAO_48GGK23uSw0p_R1fZP1Eykidd3zmq3nx6aBvtoczkD__j=w@mail.gmail.com>
References: <1478290570-30982-1-git-send-email-alexander.deucher@amd.com>
 <CAO_48GGiBXFFqxWg1fUKMVUR13QvwaH5a8eiGrOgeCbUyY0WnA@mail.gmail.com>
 <CADnq5_Nv+wgCorQ88wQ1Kc-f+nJPFzLoBMBV591zFiw-NMy3Sg@mail.gmail.com>
 <CAO_48GH5Xzc-+wWxpAqcE7t7yjQz7XS=U4M+E-PR_X+RFfvRew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAO_48GH5Xzc-+wWxpAqcE7t7yjQz7XS=U4M+E-PR_X+RFfvRew@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, DRI mailing list <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "monk.liu" <monk.liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

SGkgQWxleCwgQ2hyaXN0aWFuLAoKT24gOCBOb3ZlbWJlciAyMDE2IGF0IDA0OjEyLCBTdW1pdCBT
ZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPiB3cm90ZToKPiBIaSBBbGV4LAo+Cj4gT24g
MDctTm92LTIwMTYgMTE6MTQgUE0sICJBbGV4IERldWNoZXIiIDxhbGV4ZGV1Y2hlckBnbWFpbC5j
b20+IHdyb3RlOgo+Pgo+PiBPbiBGcmksIE5vdiA0LCAyMDE2IGF0IDY6MDMgUE0sIFN1bWl0IFNl
bXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+Cj4+IHdyb3RlOgo+PiA+IEhpIEFsZXgsCj4+
ID4KPj4gPiBUaGFua3MgZm9yIHRoZSBwYXRjaGVzLgo+PiA+Cj4+ID4gT24gNCBOb3ZlbWJlciAy
MDE2IGF0IDE0OjE2LCBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6
Cj4+ID4+IEZyb206ICJtb25rLmxpdSIgPG1vbmsubGl1QGFtZC5jb20+Cj4+ID4+Cj4+ID4+IFJl
dHVybiB0aGUgaW5kZXggb2YgdGhlIGZpcnN0IHNpZ25hbGVkIGZlbmNlLiAgVGhpcyBpbmZvcm1h
dGlvbgo+PiA+PiBpcyB1c2VmdWwgaW4gc29tZSBBUElzIGxpa2UgVnVsa2FuLgo+PiA+Pgo+PiA+
PiB2MjogcmViYXNlIG9uIGRybS1uZXh0IChmZW5jZSAtPiBkbWFfZmVuY2UpCj4+ID4+Cj4+ID4+
IFNpZ25lZC1vZmYtYnk6IG1vbmsubGl1IDxtb25rLmxpdUBhbWQuY29tPgo+PiA+PiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+ID4+IENj
OiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgo+PiA+PiAtLS0KPj4gPj4K
Pj4gPj4gVGhpcyBpcyB0aGUgc2FtZSBwYXRjaCBzZXQgSSBzZW5kIG91dCB5ZXN0ZXJkYXksIEkg
anVzdAo+PiA+PiBzcXVhc2hlZCB0aGUgYW1kZ3B1IHBhdGNoZXMgdG9nZXRoZXIgYW5kIHJlYmFz
ZWQgZXZlcnl0aGluZyBvbgo+PiA+PiB0aGUgZmVuY2UgLT4gZG1hX2ZlbmNlIHJlbmFtaW5nLiAg
VGhpcyBpcyB1c2VkIGJ5IG91ciBWSyBkcml2ZXIKPj4gPj4gYW5kIHdlIGFyZSBwbGFubmluZyB0
byB1c2UgaXQgaW4gbWVzYSBhcyB3ZWxsLgo+PiA+Pgo+PiA+Cj4+ID4gV291bGQgeW91IGJlIG9r
IGlmIEkgYXBwbHkgdGhpcyBhbmQgdGhlIGFtZGdwdSBwYXRjaCBib3RoIHRvZ2V0aGVyIHZpYQo+
PiA+IGRybS1taXNjLCBvciB3b3VsZCB5b3UgbGlrZSBtZSB0byBub3RpZnkgeW91IG9uY2UgSSBt
ZXJnZSB0aGlzIGZvciB5b3UKPj4gPiB0byB0YWtlIHRoZSBhbWRncHUgcGF0Y2ggdmlhIHlvdXIg
dHJlZT8gSSdtIGZpbmUgZWl0aGVyIHdheXMsIGJ1dAo+PiA+IHBlcmhhcHMgZHJtLW1pc2Mgd291
bGQgYmUgYSBiaXQgbmVhdGVyLgo+PiA+Cj4+Cj4+IEVpdGhlciB3YXkgd29ya3MgZm9yIG1lLiAg
V2hhdGV2ZXIgaXMgZWFzaWVyIGZvciB5b3UuCj4+Cj4gVGhhbmtzLCB3aWxsIHRha2UgdGhlc2Ug
YW5kIENocmlzdGlhbidzIHBhdGNoZXMgdGhyb3VnaCB0aGUgIGRybS1taXNjIHRyZWUsCj4gaG9w
ZWZ1bGx5IHRvZGF5LiAocmV0dXJuaW5nIGZyb20gTFBDIGFuZCBqdXN0IGxhbmRlZCBhdCBteSBo
b21lIGNpdHksIDRhbQo+IGhlcmUsIGJ1dCB3aWxsIGhvcGUgdG8gcHVzaCB0aGVzZSB0b2RheSEg
KQo+PiBBbGV4Cj4KCkFwcGxpZWQgdG8gZHJtLW1pc2M7IFRoYW5rcyEKCj4gQmVzdCwKPiBTdW1p
dC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRl
dmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
