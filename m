From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Refresh rq selection for job after ASIC
 reset
Date: Fri, 19 Oct 2018 16:50:30 +0000
Message-ID: <3c6d95a7-93b7-4ee5-db15-be66e5c71a0c@amd.com>
References: <1539888261-331-1-git-send-email-andrey.grodzovsky@amd.com>
 <1539888261-331-3-git-send-email-andrey.grodzovsky@amd.com>
 <92efce5c-f9ad-847b-09b3-e7c6f7f13ff6@amd.com>
 <0928be66-d606-84b8-4fa8-399e5615f75c@amd.com>
 <732e8d99-e681-e2a4-506d-6aed0d7fc594@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0112562481=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <732e8d99-e681-e2a4-506d-6aed0d7fc594@gmail.com>
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
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0112562481==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_3c6d95a793b74ee5db15be66e5c71a0camdcom_"

--_000_3c6d95a793b74ee5db15be66e5c71a0camdcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhhdCBteSBuZXh0IHN0ZXAuDQoNCkFuZHJleQ0KDQpPbiAxMC8xOS8yMDE4IDEyOjI4IFBNLCBD
aHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KICBGcm9tIG15IHRlc3RpbmcgbG9va3MgbGlrZSB3ZSBj
YW4sIGNvbXB1dGUgcmluZyAwIGlzIGRlYWQgYnV0IElCIHRlc3RzDQpwYXNzIG9uIG90aGVyIGNv
bXB1dGUgcmluZ3MuDQoNCkludGVyZXN0aW5nLCBidXQgSSB3b3VsZCByYXRoZXIgaW52ZXN0aWdh
dGUgd2h5IGNvbXB1dGUgcmluZyAwIGlzIGRlYWQgd2hpbGUgb3RoZXIgc3RpbGwgd29yay4NCg0K

--_000_3c6d95a793b74ee5db15be66e5c71a0camdcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <CBAD8D08CDA08F4BAC04E2538C96717B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHRleHQ9IiMwMDAwMDAi
IGJnY29sb3I9IiNGRkZGRkYiPg0KPHA+VGhhdCBteSBuZXh0IHN0ZXAuPC9wPg0KPHA+QW5kcmV5
PGJyPg0KPC9wPg0KPGJyPg0KPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAxMC8xOS8y
MDE4IDEyOjI4IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOjxicj4NCjwvZGl2Pg0KPGJsb2Nr
cXVvdGUgdHlwZT0iY2l0ZSIgY2l0ZT0ibWlkOjczMmU4ZDk5LWU2ODEtZTJhNC01MDZkLTZhZWQw
ZDdmYzU5NEBnbWFpbC5jb20iPg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9ImNvbG9y
OiAjMDAwMDAwOyI+Jm5ic3A7IEZyb20gbXkgdGVzdGluZyBsb29rcyBsaWtlIHdlIGNhbiwgY29t
cHV0ZSByaW5nIDAgaXMgZGVhZCBidXQgSUIgdGVzdHMNCjxicj4NCnBhc3Mgb24gb3RoZXIgY29t
cHV0ZSByaW5ncy4gPGJyPg0KPC9ibG9ja3F1b3RlPg0KPGJyPg0KSW50ZXJlc3RpbmcsIGJ1dCBJ
IHdvdWxkIHJhdGhlciBpbnZlc3RpZ2F0ZSB3aHkgY29tcHV0ZSByaW5nIDAgaXMgZGVhZCB3aGls
ZSBvdGhlciBzdGlsbCB3b3JrLg0KPC9ibG9ja3F1b3RlPg0KPGJyPg0KPC9ib2R5Pg0KPC9odG1s
Pg0K

--_000_3c6d95a793b74ee5db15be66e5c71a0camdcom_--

--===============0112562481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0112562481==--
