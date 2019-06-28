From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH libdrm 1/9] amdgpu: Pass file descriptor directly to
 amdgpu_close_kms_handle
Date: Fri, 28 Jun 2019 18:11:07 +0100
Message-ID: <CACvgo53dE7Hx_VWQVdu18wewJOM5_mK5GnRZ=h2_zTOoxcqBmw@mail.gmail.com>
References: <20190624165406.13682-1-michel@daenzer.net>
 <20190624165406.13682-2-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190624165406.13682-2-michel@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCAyNCBKdW4gMjAxOSBhdCAxNzo1NCwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVu
emVyLm5ldD4gd3JvdGU6Cj4KPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJA
YW1kLmNvbT4KPgo+IEFuZCBwcm9wYWdhdGUgZHJtSW9jdGwncyByZXR1cm4gdmFsdWUuCj4KPiBU
aGlzIGFsbG93cyByZXBsYWNpbmcgYWxsIHJlbWFpbmluZyBvcGVuLWNvZGVkIERSTV9JT0NUTF9H
RU1fQ0xPU0UKPiBpb2N0bCBjYWxscyB3aXRoIGFtZGdwdV9jbG9zZV9rbXNfaGFuZGxlIGNhbGxz
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5j
b20+Cj4gLS0tCj4gIGFtZGdwdS9hbWRncHVfYm8uYyB8IDM1ICsrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAyMCBk
ZWxldGlvbnMoLSkKPgpGd2l3IHBhdGNoZXMgMS0zIGFyZToKUmV2aWV3ZWQtYnk6IEVtaWwgVmVs
aWtvdiA8ZW1pbC5sLnZlbGlrb3ZAZ21haWwuY29tPgoKLUVtaWwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
