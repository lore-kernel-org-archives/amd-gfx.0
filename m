From: Yang Xiao <YangX92@hotmail.com>
Subject: [PATCH]     drm/amd/amdgpu: Test for PCI root bus before assuming
 bus->self
Date: Tue, 27 Nov 2018 03:33:35 +0000
Message-ID: <HK0PR01MB2163A94895C17576704894E5ADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
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
To: "alexander.deucher@amd.com" <alexander.deucher@amd.com>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "David1.Zhou@amd.com" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>
Cc: Yang Xiao <YangX92@hotmail.com>, "ray.huang@amd.com" <ray.huang@amd.com>, "Rex.Zhu@amd.com" <Rex.Zhu@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogWW91bmdfWCA8WWFuZ1g5MkBob3RtYWlsLmNvbT4KCiAgICBJZiB3ZSBhc3NpZ24gYW4g
YW1kIGRldmljZSB0byBhIHZpcnR1YWwgbWVjaGluZSwgd2UgY2FuIG5vIGxvbmdlcgogICAgYXNz
dW1lIGEgZml4ZWQgaGFyZHdhcmUgdG9wb2xvZ3ksIGxpa2UgdGhlIEdQVSBoYXZpbmcgYSBwYXJl
bnQgZGV2aWNlLgogICAgVGhpcyBwYXRjaCBzaW1wbHkgYWRkcyBwY2lfaXNfcm9vdF9idXMoKSB0
ZXN0cyB0byBhdm9pZCBwYXNzaW5nIGEKICAgIE5VTEwgcG9pbnRlciB0byBQQ0kgYWNjZXNzIGZ1
bmN0aW9ucy4KCiAgICBTZWUgY29tbWl0IGU3OWQ1YzA4NzBlZSAoImRybS9hbWRncHU6IGNoZWNr
IGJlZm9yZSBjaGVja2luZyBwY2kgYnJpZGdlCiAgICByZWdpc3RlcnMiKSBhbmQgY29tbWl0IDBi
ZDI1MmRlNzhkNCAoInJhZGVvbjogVGVzdCBmb3IgUENJIHJvb3QgYnVzCiAgICBiZWZvcmUgYXNz
dW1pbmcgYnVzLT5zZWxmIikgZm9yIGRldGFpbHMuCgpTaWduZWQtb2ZmLWJ5OiBZb3VuZ19YIDxZ
YW5nWDkyQGhvdG1haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npay5j
IHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2Npay5jCmluZGV4IGY0MWY1ZjUuLjhiNTFmYTggMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npay5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2Npay5jCkBAIC0xNjIyLDcgKzE2MjIsOCBAQCBzdGF0aWMgdm9pZCBjaWtf
cHJvZ3JhbV9hc3BtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQkJaWYgKG9yaWcgIT0g
ZGF0YSkKIAkJCQlXUkVHMzJfUENJRShpeFBDSUVfTENfTElOS19XSURUSF9DTlRMLCBkYXRhKTsK
IAotCQkJaWYgKCFkaXNhYmxlX2Nsa3JlcSkgeworCQkJaWYgKCFkaXNhYmxlX2Nsa3JlcSAmJgor
CQkJICAgICFwY2lfaXNfcm9vdF9idXMoYWRldi0+cGRldi0+YnVzKSkgewogCQkJCXN0cnVjdCBw
Y2lfZGV2ICpyb290ID0gYWRldi0+cGRldi0+YnVzLT5zZWxmOwogCQkJCXUzMiBsbmtjYXA7CiAK
LS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
