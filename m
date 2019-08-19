From: Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH ARM] selftests, arm64: fix uninitialized symbol in tags_test.c
Date: Mon, 19 Aug 2019 15:14:42 +0200
Message-ID: <00eb8ba84205c59cac01b1b47615116a461c302c.1566220355.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Yishai Hadas <yishaih@mellanox.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Leon Romanovsky <leon@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>, Jason Gunthorpe <jgg@z>
List-Id: amd-gfx.lists.freedesktop.org

Fix tagged_ptr not being initialized when TBI is not enabled.

Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/tags_test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags_test.c
index 22a1b266e373..5701163460ef 100644
--- a/tools/testing/selftests/arm64/tags_test.c
+++ b/tools/testing/selftests/arm64/tags_test.c
@@ -14,15 +14,17 @@
 int main(void)
 {
 	static int tbi_enabled = 0;
-	struct utsname *ptr, *tagged_ptr;
+	unsigned long tag = 0;
+	struct utsname *ptr;
 	int err;
 
 	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
 		tbi_enabled = 1;
 	ptr = (struct utsname *)malloc(sizeof(*ptr));
 	if (tbi_enabled)
-		tagged_ptr = (struct utsname *)SET_TAG(ptr, 0x42);
-	err = uname(tagged_ptr);
+		tag = 0x42;
+	ptr = (struct utsname *)SET_TAG(ptr, tag);
+	err = uname(ptr);
 	free(ptr);
 
 	return err;
-- 
2.23.0.rc1.153.gdeed80330f-goog
