From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/amdgpu: Fix a typo in the include header guard of 'navi12_ip_offset.h'
Date: Sun, 18 Aug 2019 17:59:57 +0200
Message-ID: <20190818155957.4029-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, xiaojie.yuan@amd.com, Hawking.Zhang@amd.com, Jack.Xiao@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: amd-gfx.lists.freedesktop.org

'_navi10_ip_offset_HEADER' is already used in 'navi10_ip_offset.h', so use
'_navi12_ip_offset_HEADER' instead here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/include/navi12_ip_offset.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/navi12_ip_offset.h b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
index 229e8fddfcc1..6c2cc6296c06 100644
--- a/drivers/gpu/drm/amd/include/navi12_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/navi12_ip_offset.h
@@ -18,8 +18,8 @@
  * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
-#ifndef _navi10_ip_offset_HEADER
-#define _navi10_ip_offset_HEADER
+#ifndef _navi12_ip_offset_HEADER
+#define _navi12_ip_offset_HEADER
 
 #define MAX_INSTANCE                                       7
 #define MAX_SEGMENT                                        5
-- 
2.20.1
