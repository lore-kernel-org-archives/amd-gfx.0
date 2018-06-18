From: David Binderman <dcb314@hotmail.com>
Subject: linux-4.18-rc1/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:207: broken
 nested if ?
Date: Mon, 18 Jun 2018 08:19:08 +0000
Message-ID: <AM4PR08MB2819DB7F483B7EEB31FE89699C710@AM4PR08MB2819.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "alexander.deucher@amd.com" <alexander.deucher@amd.com>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "David1.Zhou@amd.com" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

SGVsbG8gdGhlcmUsCgpbbGludXgtNC4xOC1yYzEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Zjbi5jOjIwOF06ICh3YXJuaW5nKSBJZGVudGljYWwgaW5uZXIgJ2lmJyBjb25kaXRp
b24gaXMgYWx3YXlzIHRydWUuCgpTb3VyY2UgY29kZSBpcwoKICAgICAgICBpZiAoc2V0X2Nsb2Nr
cyAmJiBhZGV2LT5wbS5kcG1fZW5hYmxlZCkgewogICAgICAgICAgICAgICAgaWYgKGFkZXYtPnBt
LmRwbV9lbmFibGVkKQogICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfZHBtX2VuYWJsZV91
dmQoYWRldiwgdHJ1ZSk7CiAgICAgICAgICAgICAgICBlbHNlCiAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9JUF9C
TE9DS19UWVBFX1ZDTiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQU1EX1BHX1NUQVRFX1VOR0FURSk7CgpTbyBzZWNvbmQgZnVu
Y3Rpb24gY2FsbCBuZXZlciBoYXBwZW5zLiBTdWdnZXN0IGNvZGUgcmV3b3JrLgoKUmVnYXJkcwoK
RGF2aWQgQmluZGVybWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
