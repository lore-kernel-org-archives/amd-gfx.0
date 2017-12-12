From: "Yu, Qiang" <Qiang.Yu@amd.com>
Subject: Re: [PATCH libdrm] amdgpu: Remove dummy CU_ASSERT_EQUAL.
Date: Tue, 12 Dec 2017 13:52:33 +0000
Message-ID: <CY4PR1201MB0117477808431E1A3F8BF7D58F340@CY4PR1201MB0117.namprd12.prod.outlook.com>
References: <1513085813-2836-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1513085813-2836-1-git-send-email-andrey.grodzovsky@amd.com>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "Jin, Anna" <Anna.Jin@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huan,
 Alvin" <Alvin.Huan@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

UmV2aWV3ZWQtYnk6IFFpYW5nIFl1IDxRaWFuZy5ZdUBhbWQuY29tPgoKUmVnYXJkcywKUWlhbmcK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRnJvbTogQW5kcmV5IEdy
b2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+ClNlbnQ6IFR1ZXNkYXksIERlY2Vt
YmVyIDEyLCAyMDE3IDk6MzY6NTMgUE0KVG86IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBZdSwgUWlhbmc7IE1hLCBMZTsg
SHVhbiwgQWx2aW47IEppbiwgQW5uYTsgR3JvZHpvdnNreSwgQW5kcmV5ClN1YmplY3Q6IFtQQVRD
SCBsaWJkcm1dIGFtZGdwdTogUmVtb3ZlIGR1bW15IENVX0FTU0VSVF9FUVVBTC4KCkZpeGVzIHRl
c3QgZmFpbHVyZSBvbiByaGVsLgoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFu
ZHJleS5ncm9kem92c2t5QGFtZC5jb20+Ci0tLQogdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMg
fCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0
cy9hbWRncHUvYmFzaWNfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCmluZGV4
IGE3OGNmNTIuLjQ3NGE2NzkgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5j
CisrKyBiL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCkBAIC0xNDU5LDggKzE0NTksNiBAQCBz
dGF0aWMgdm9pZCBhbWRncHVfc3luY19kZXBlbmRlbmN5X3Rlc3Qodm9pZCkKICAgICAgICBzdGF0
aWMgdWludDMyX3QgKnB0cjsKICAgICAgICB1aW50NjRfdCBzZXFfbm87CgotICAgICAgIENVX0FT
U0VSVF9FUVVBTChyLCAwKTsKLQogICAgICAgIHIgPSBhbWRncHVfY3NfY3R4X2NyZWF0ZShkZXZp
Y2VfaGFuZGxlLCAmY29udGV4dF9oYW5kbGVbMF0pOwogICAgICAgIENVX0FTU0VSVF9FUVVBTChy
LCAwKTsKICAgICAgICByID0gYW1kZ3B1X2NzX2N0eF9jcmVhdGUoZGV2aWNlX2hhbmRsZSwgJmNv
bnRleHRfaGFuZGxlWzFdKTsKLS0KMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2RyaS1kZXZlbAo=
