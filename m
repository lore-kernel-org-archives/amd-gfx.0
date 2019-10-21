From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH hmm 08/15] xen/gntdev: Use select for DMA_SHARED_BUFFER
Date: Mon, 21 Oct 2019 19:12:23 +0000
Message-ID: <20191021191219.GJ6285@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <20191015181242.8343-9-jgg@ziepe.ca>
 <6f60f558-20db-1749-044d-a46697258c39@suse.com>
 <91329d7d-9db5-057e-59d2-887254083da0@epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <91329d7d-9db5-057e-59d2-887254083da0@epam.com>
Content-Language: en-US
Content-ID: <8BF592EA6461D548874DB6BE9FEE8E38@eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Cc: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Stefano Stabellini <sstabellini@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBPY3QgMTYsIDIwMTkgYXQgMDY6MzU6MTVBTSArMDAwMCwgT2xla3NhbmRyIEFuZHJ1
c2hjaGVua28gd3JvdGU6DQo+IE9uIDEwLzE2LzE5IDg6MTEgQU0sIErDvHJnZW4gR3Jvw58gd3Jv
dGU6DQo+ID4gT24gMTUuMTAuMTkgMjA6MTIsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4g
RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPg0KPiA+Pg0KPiA+PiBETUFf
U0hBUkVEX0JVRkZFUiBjYW4gbm90IGJlIGVuYWJsZWQgYnkgdGhlIHVzZXIgKGl0IHJlcHJlc2Vu
dHMgYSANCj4gPj4gbGlicmFyeQ0KPiA+PiBzZXQgaW4gdGhlIGtlcm5lbCkuIFRoZSBrY29uZmln
IGNvbnZlbnRpb24gaXMgdG8gdXNlIHNlbGVjdCBmb3Igc3VjaA0KPiA+PiBzeW1ib2xzIHNvIHRo
ZXkgYXJlIHR1cm5lZCBvbiBpbXBsaWNpdGx5IHdoZW4gdGhlIHVzZXIgZW5hYmxlcyBhIGtjb25m
aWcNCj4gPj4gdGhhdCBuZWVkcyB0aGVtLg0KPiA+Pg0KPiA+PiBPdGhlcndpc2UgdGhlIFhFTl9H
TlRERVZfRE1BQlVGIGtjb25maWcgaXMgb3Zlcmx5IGRpZmZpY3VsdCB0byBlbmFibGUuDQo+ID4+
DQo+ID4+IEZpeGVzOiA5MzJkNjU2MjE3OWUgKCJ4ZW4vZ250ZGV2OiBBZGQgaW5pdGlhbCBzdXBw
b3J0IGZvciBkbWEtYnVmIFVBUEkiKQ0KPiA+PiBDYzogT2xla3NhbmRyIEFuZHJ1c2hjaGVua28g
PG9sZWtzYW5kcl9hbmRydXNoY2hlbmtvQGVwYW0uY29tPg0KPiA+PiBDYzogQm9yaXMgT3N0cm92
c2t5IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT4NCj4gPj4gQ2M6IHhlbi1kZXZlbEBsaXN0
cy54ZW5wcm9qZWN0Lm9yZw0KPiA+PiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29t
Pg0KPiA+PiBDYzogU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxsYW5veC5jb20+DQo+
ID4NCj4gPiBSZXZpZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiA+
DQo+IFJldmlld2VkLWJ5OiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyA8b2xla3NhbmRyX2FuZHJ1
c2hjaGVua29AZXBhbS5jb20+DQoNClRoYW5rcyBPbGVrc2FuZHIgYW5kIEp1ZXJnZW4sIGNhbiB5
b3UgYWxzbyBnaXZlIG1lIHNvbWUgYWR2aWNlIG9uIGhvdw0KdG8gcHJvZ3Jlc3MgdGhlIG1vcmUg
Y29tcGxleCBwYXRjaDoNCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTE5
MTM2OS8NCg0KSXMgdGhpcyBnbnRkZXYgc3R1ZmYgc3RpbGwgaW4tdXNlPyBJIHN0cnVnZ2xlZCBh
IGJpdCB0byB1bmRlcnN0YW5kDQp3aGF0IGl0IGlzIGRvaW5nLCBidXQgSSB0aGluayBJIG1hZGUg
YSByZWFzb25hYmxlIGd1ZXNzPw0KDQpKYXNvbg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVs
