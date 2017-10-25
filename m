From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amd/display: assign fb_location only if bo is pinned
Date: Wed, 25 Oct 2017 10:08:07 +0200
Message-ID: <c270f341-c59b-7f56-eb1a-94c765673b89@daenzer.net>
References: <1508852848-17713-1-git-send-email-shirish.s12@gmail.com>
 <BN6PR12MB18268EA378DD476F38B2FED7F2470@BN6PR12MB1826.namprd12.prod.outlook.com>
 <44152644-4a1f-23b5-3b3a-81fc9bb90007@amd.com>
 <59f795cf-f25c-2b7b-9775-0f685131d7d8@amd.com>
 <41ca6c61-1ade-8bf3-cc45-c1adf8606976@amd.com>
 <21693e67-aa36-a4a9-12ac-18e6c5a32e63@daenzer.net>
 <1c36babd-69ee-e701-d857-c6eb8ebab2c3@amd.com>
 <efda8b1f-763c-939a-a1e6-5dd1ad5d3e81@daenzer.net>
 <3437290b-97c3-9c2a-a800-45321c10e0f3@amd.com>
 <d41c9d08-000d-44f4-43d5-e4cda19bc728@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <d41c9d08-000d-44f4-43d5-e4cda19bc728@amd.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "S, Shirish" <sshankar@amd.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, dri-devel@lists.freedesktop.org, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjUvMTAvMTcgMDc6MTggQU0sIFMsIFNoaXJpc2ggd3JvdGU6Cj4KPiBBbmRyZXksCj4gVGls
bCBub3cgdGhlIGdldF9mYl9pbmZvKCkgbmV2ZXIgY2FsY3VsYXRlZCBmYl9sb2NhdGlvbihhcyBh
ZGRyUmVxIHdhcwo+IGFsd2F5cyBmYWxzZSksIGJ1dCBzaW5jZSBub3cgaXRzIHJlcXVpcmVkIHRv
IHByb2dyYW0gdGhlIGhpZ2ggcGFydCBvZgo+IHRoZSBhZGRyZXNzIHN0cnVjdHVyZSwKPiBjYW4g
eW91IG1vdmUgaXQgYmFjayBpbnRvIHRoZSBjb21taXQgc2NvcGUgYW5kIGVuc3VyZSB0aGF0IGZi
X2xvY2F0aW9uCj4gaXMgY2FsY3VsYXRlZCBldmVyeXRpbWUuKEkgaGF2ZSBsaW1pdGVkIGtub3ds
ZWRnZSBiZWhpbmQgd2h5IGl0IHdhcwo+IG1vdmVkIG91dCkKPiBBbmQgaW4gY2FzZSBpZiB5b3Ug
aW5zaXN0IG9uIGFkZGluZyBwaW4gJiB1bnBpbiBpbiBhdG9taWNfY2hlY2soKSBzY29wZQo+IGkg
Y2FuIHBvc3QgYSBwYXRjaCBmb3IgaXQuCgpUaGUgbGF0dGVyIG9uIGl0cyBvd24gY291bGRuJ3Qg
cmVhbGx5IHNvbHZlIHRoZSBwcm9ibGVtIGFueXdheTogV2hpbGUgYQpCTyBpcyB1bnBpbm5lZCwg
aXRzIE1DIGFkZHJlc3MgY2FuIGNoYW5nZSBhdCBhbnkgdGltZS4gVGhlIE1DIGFkZHJlc3MKcHJv
Z3JhbW1lZCB0byB0aGUgaGFyZHdhcmUgbXVzdCBiZSBkZXRlcm1pbmVkIHdoaWxlIHRoZSBCTyBp
cyBhbmQgc3RheXMKcGlubmVkLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJl
IGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Bl
cgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
