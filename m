From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH] drm/amd/powerplay: fix semicolon.cocci warnings
Date: Sun, 6 Aug 2017 16:00:21 +0800
Message-ID: <20170806080021.GA82432@cairo.lkp.intel.com>
References: <201708061610.sPRXik2Y%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <201708061610.sPRXik2Y%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rex Zhu <Rex.Zhu@amd.com>
Cc: dri-devel@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Eric Huang <JinHuiEric.Huang@amd.com>, kbuild-all@01.org, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: amd-gfx.lists.freedesktop.org

ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21n
ci5jOjIyNzM6NjEtNjI6IFVubmVlZGVkIHNlbWljb2xvbgoKCiBSZW1vdmUgdW5uZWVkZWQgc2Vt
aWNvbG9uLgoKR2VuZXJhdGVkIGJ5OiBzY3JpcHRzL2NvY2NpbmVsbGUvbWlzYy9zZW1pY29sb24u
Y29jY2kKCkZpeGVzOiBiZGI4Y2QxMGI5OWQgKCJkcm0vYW1kL3Bvd2VycGxheTogZW5hYmxlIEFD
RyBmZWF0dXJlIG9uIHZlZ2ExMC4iKQpDQzogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBGZW5nZ3VhbmcgV3UgPGZlbmdndWFuZy53dUBpbnRlbC5jb20+Ci0tLQoKIHZl
Z2ExMF9od21nci5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wb3dlcnBs
YXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jCkBAIC0yMjcwLDcgKzIyNzAsNyBAQCBz
dGF0aWMgaW50IHZlZ2ExMF9hY2dfZW5hYmxlKHN0cnVjdCBwcF9oCiAJCXNtdW1fc2VuZF9tc2df
dG9fc21jKGh3bWdyLT5zbXVtZ3IsIFBQU01DX01TR19Jbml0aWFsaXplQWNnKTsKIAogCQlzbXVt
X3NlbmRfbXNnX3RvX3NtYyhod21nci0+c211bWdyLCBQUFNNQ19NU0dfUnVuQWNnQnRjKTsKLQkJ
dmVnYTEwX3JlYWRfYXJnX2Zyb21fc21jKGh3bWdyLT5zbXVtZ3IsICZhZ2NfYnRjX3Jlc3BvbnNl
KTs7CisJCXZlZ2ExMF9yZWFkX2FyZ19mcm9tX3NtYyhod21nci0+c211bWdyLCAmYWdjX2J0Y19y
ZXNwb25zZSk7CiAKIAkJaWYgKDEgPT0gYWdjX2J0Y19yZXNwb25zZSkgewogCQkJaWYgKDEgPT0g
ZGF0YS0+YWNnX2xvb3Bfc3RhdGUpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
