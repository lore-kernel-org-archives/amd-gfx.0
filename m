From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 1/2] drm/ttm: remove unused placement flags
Date: Fri, 9 Sep 2016 14:54:54 +0100
Message-ID: <CACvgo53AAEsxAoQvAe=ffMnQiZiE=MPWne2Abg=rAt4bRkK8NQ@mail.gmail.com>
References: <1473342102-324-1-git-send-email-deathsimple@vodafone.de>
 <57D2598C.1070903@amd.com> <20160909070116.GA20574@flora>
 <79675437-85ae-2fbf-93e1-b49321e6a41e@vodafone.de>
 <BN6PR12MB120407ACA888A0E57CA16D7AFCFA0@BN6PR12MB1204.namprd12.prod.outlook.com>
 <79da37c4-8259-5301-8a42-ef2f28769728@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <79da37c4-8259-5301-8a42-ef2f28769728@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cui,
 Flora" <Flora.Cui@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gOSBTZXB0ZW1iZXIgMjAxNiBhdCAxMjoyNCwgQ2hyaXN0aWFuIEvDtm5pZyA8ZGVhdGhzaW1w
bGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+IEhpIEhhd2tpbmcsCj4KPj4gUmVtb3ZpbmcgdGhlIGZs
YWcgd2lsbCBtYWtlIHR0bV9tZW1fdHlwZV9mcm9tX3BsYWNlIHNraXAgY291bnRpbmcgdGhlCj4+
IGNvcnJlc3BvbmRpbmcgcGxhY2VtZW50IGFuZCB0aHVzIGhhdmUgaW1wYWN0IG9uIG1lbSByZWdp
b24gY3JlYXRlIGFuZCBibwo+PiBtb3ZlbWVudC4KPgo+IEFuZCB0aGF0IGlzIGV4YWN0bHkgdGhl
IHJlYXNvbiB3aHkgSSB3YW50IHRvIHJlbW92ZSB0aGUgdW51c2VkIGZsYWdzLgo+Cj4+IFRoZXJl
IGlzIG5vIGd1YXJhbnRlZSB0aGF0IGFtZGdwdSB3b3VsZCBuZXZlciBpbnRyb2R1Y2UgbmV3IG1l
bW9yeSBkb21haW4KPj4gaW4gZnV0dXJlLgo+Cj4gSXJyZWxldmFudCwgaWYgYW55IGRyaXZlciB3
YW50cyB0byB1c2UgYWRkaXRpb25hbCBkb21haW5zIGl0IHNob3VsZCBhZGQgdGhlbQo+IHdoZW4g
dGhleSBhcmUgdXNlZC4KPgo+IEJUVzogV2h5IHdvdWxkIHdlIHdhbnQgdG8gYWRkIGFub3RoZXIg
VFRNIGRvbWFpbj8gSSByZWFsbHkgZG9uJ3Qgc2VlIGFueQo+IG5lZWQgZm9yIHRoYXQuCj4KPj4g
VGhlbiBob3cgYWJvdXQga2VlcCB0aGVzZSBmbGFncz8KPgo+IEFjdHVhbGx5IHdlIHVzZWQgdG8g
aGF2ZSBhdXRvbWF0ZWQgc2Nhbm5lcnMgd2hpY2ggY29tcGxhaW4gYWJvdXQgdW51c2VkCj4gY29k
ZS4gSSdtIHdvbmRlcmluZyB3aHkgdGhleSBkb24ndCBkZXRlY3RlZCB0aGF0IGVhcmxpZXIuCj4K
PiBBbnl3YXkgYW55IGNvZGUgd2hpY2ggaXNuJ3QgdXNlZCBpbiBhIHdoaWxlIHNob3VsZCBiZSBy
ZW1vdmVkLgo+CkZ3aXcgSSBzZWNvbmQgQ2hyaXN0aWFuIGhlcmUuIElmIHRoZXkgYXJlIHVudXNl
ZCBpbiBvcGVuLXNvdXJjZQpkcml2ZXJzIHRoZXJlJ3Mgbm8gcmVhc29uIHRvIGtlZXAgdGhlbS4K
SWYvYXMgdGhhdCBjaGFuZ2VzIHRoZSAobmV3bHkgaW50cm9kdWNlZCkgdXNlciBjYW4gYWRkIGJh
Y2sgdGhlIHJlbGV2YW50IGNvZGUuCgpJZiBjbG9zZWQtc291cmNlIGRyaXZlcihzKSB1c2UgdGhl
bSwgdGhlbiB0aGV5IGNhbiBrZWVwIGl0IGFzIHBhcnQgb2YKdGhlaXIgYmxvYi4gVXBzdHJlYW0g
a2VybmVsIGRvZXMgbm90IGNhdGVyIGZvciBjbG9zZWQtc291cmNlIGRyaXZlcnMsCnBlcmlvZC4K
SSByZWFsaXNlIHRoYXQncyBub3QgdGhlIGFuc3dlciBzb21lIGFyZSBob3BpbmcgZm9yLCBzbyBp
ZiB5b3Ugd2FudCB0bwpxdWVzdGlvbiBpdCB0YWtlIGl0IHVwIHdpdGggTGludXMgYW5kIGNvLgoK
UmVnYXJkcywKRW1pbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
