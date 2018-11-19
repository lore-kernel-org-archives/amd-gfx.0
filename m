From: "Zuo, Jerry" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amd/dm: Understand why attaching path/tile
 properties are needed
Date: Mon, 19 Nov 2018 19:44:55 +0000
Message-ID: <BY1PR12MB0406A41977791358BD0C0C0DE5D80@BY1PR12MB0406.namprd12.prod.outlook.com>
References: <20181116232443.1709-1-lyude@redhat.com>
 <20181116232443.1709-3-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181116232443.1709-3-lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Li,
 Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Cheng, Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, "Li, Roman" <Roman.Li-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJvbTogTHl1ZGUgUGF1bCA8bHl1ZGVAcmVkaGF0
LmNvbT4gClNlbnQ6IE5vdmVtYmVyIDE2LCAyMDE4IDY6MjUgUE0KVG86IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCkNjOiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5j
b20+OyBMaSwgU3VuIHBlbmcgKExlbykgPFN1bnBlbmcuTGlAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaG91LCBEYXZpZChDaHVuTWluZykgPERhdmlkMS5a
aG91QGFtZC5jb20+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+OyBadW8sIEplcnJ5
IDxKZXJyeS5adW9AYW1kLmNvbT47IExpLCBSb21hbiA8Um9tYW4uTGlAYW1kLmNvbT47IENoZW5n
LCBUb255IDxUb255LkNoZW5nQGFtZC5jb20+OyBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVy
QGZmd2xsLmNoPjsgUywgU2hpcmlzaCA8U2hpcmlzaC5TQGFtZC5jb20+OyBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnClN1YmplY3Q6
IFtQQVRDSCAyLzJdIGRybS9hbWQvZG06IFVuZGVyc3RhbmQgd2h5IGF0dGFjaGluZyBwYXRoL3Rp
bGUgcHJvcGVydGllcyBhcmUgbmVlZGVkCgpQYXRoIHByb3BlcnR5IGlzIHVzZWQgZm9yIHVzZXJz
cGFjZSB0byBrbm93IHdoYXQgTVNUIGNvbm5lY3RvciBnb2VzIHRvIHdoYXQgYWN0dWFsIERSTSBE
aXNwbGF5UG9ydCBjb25uZWN0b3IsIHRoZSB0aWxpbmcgcHJvcGVydHkgaXMgZm9yIHRpbGluZyBj
b25maWd1cmF0aW9ucy4gTm90IHN1cmUgd2hhdCBlbHNlIHRoZXJlIGlzIHRvIGZpZ3VyZSBvdXQu
CgpTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVsIDxseXVkZUByZWRoYXQuY29tPgpSZXZpZXdlZC1i
eTogSmVycnkgKEZhbmd6aGkpIFp1byA8SmVycnkuWnVvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMgfCAzIC0t
LQogMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYwpp
bmRleCAwY2NhMTgwOWZkY2QuLjFiMGQyMDlkODM2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMK
QEAgLTM0NSw5ICszNDUsNiBAQCBkbV9kcF9hZGRfbXN0X2Nvbm5lY3RvcihzdHJ1Y3QgZHJtX2Rw
X21zdF90b3BvbG9neV9tZ3IgKm1nciwKIAlkcm1fY29ubmVjdG9yX2F0dGFjaF9lbmNvZGVyKCZh
Y29ubmVjdG9yLT5iYXNlLAogCQkJCSAgICAgJmFjb25uZWN0b3ItPm1zdF9lbmNvZGVyLT5iYXNl
KTsKIAotCS8qCi0JICogVE9ETzogdW5kZXJzdGFuZCB3aHkgdGhpcyBvbmUgaXMgbmVlZGVkCi0J
ICovCiAJZHJtX29iamVjdF9hdHRhY2hfcHJvcGVydHkoCiAJCSZjb25uZWN0b3ItPmJhc2UsCiAJ
CWRldi0+bW9kZV9jb25maWcucGF0aF9wcm9wZXJ0eSwKLS0KMi4xOS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
