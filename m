From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 0/3] GPU-DRM-Radeon: Fine-tuning for three function
 implementations
Date: Wed, 10 May 2017 09:23:31 +0900
Message-ID: <8c4e7dde-06d5-3f13-2322-f661e9d3dbf4@daenzer.net>
References: <74d2df52-f509-e6d2-5b35-e25b7cbd1fbe@users.sourceforge.net>
 <799fb921-f620-9054-680d-90b14e4c517c@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <799fb921-f620-9054-680d-90b14e4c517c@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, SF Markus Elfring <elfring@users.sourceforge.net>, Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>
Cc: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMDMvMDUvMTcgMDk6NDYgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMDIuMDUu
MjAxNyB1bSAyMjowNCBzY2hyaWViIFNGIE1hcmt1cyBFbGZyaW5nOgo+PiBGcm9tOiBNYXJrdXMg
RWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+Cj4+IERhdGU6IFR1ZSwgMiBN
YXkgMjAxNyAyMjowMDowMiArMDIwMAo+Pgo+PiBUaHJlZSB1cGRhdGUgc3VnZ2VzdGlvbnMgd2Vy
ZSB0YWtlbiBpbnRvIGFjY291bnQKPj4gZnJvbSBzdGF0aWMgc291cmNlIGNvZGUgYW5hbHlzaXMu
Cj4+Cj4+IE1hcmt1cyBFbGZyaW5nICgzKToKPj4gICAgVXNlIHNlcV9wdXRjKCkgaW4gcmFkZW9u
X3NhX2JvX2R1bXBfZGVidWdfaW5mbygpCj4+ICAgIFVzZSBzZXFfcHV0cygpIGluIHJhZGVvbl9k
ZWJ1Z2ZzX3BtX2luZm8oKQo+PiAgICBVc2Ugc2VxX3B1dHMoKSBpbiByMTAwX2RlYnVnZnNfY3Bf
Y3NxX2ZpZm8oKQo+IAo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+CgpCYXNlZCBvbgpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9h
cmNoaXZlcy9kcmktZGV2ZWwvMjAxNy1NYXkvMTQwODM3Lmh0bWwKYW5kIGZvbGxvd3VwcywgSSdt
IGFmcmFpZCB3ZSdsbCBoYXZlIHRvIG1ha2Ugc3VyZSBNYXJrdXMnIHBhdGNoZXMgaGF2ZQpiZWVu
IHRlc3RlZCBhZGVxdWF0ZWx5IGJlZm9yZSBhcHBseWluZyB0aGVtLgoKCi0tIApFYXJ0aGxpbmcg
TWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5h
bWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAg
ICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
