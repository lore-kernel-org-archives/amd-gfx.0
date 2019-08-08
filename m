From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: drm/amdgpu: replace readq/writeq with atomic64 operations
Date: Thu, 8 Aug 2019 12:25:35 -0700
Message-ID: <20190808192535.GA18697@roeck-us.net>
References: <20190807025640.682-1-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190807025640.682-1-tao.zhou1@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tao Zhou <tao.zhou1@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org, amd-gfx@lists.freedesktop.org, broonie@kernel.org, linux-next@vger.kernel.org, alexander.deucher@amd.com, akpm@linux-foundation.org, christian.koenig@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBBdWcgMDcsIDIwMTkgYXQgMTA6NTY6NDBBTSArMDgwMCwgVGFvIFpob3Ugd3JvdGU6
Cj4gcmVhZHEvd3JpdGVxIGFyZSBub3Qgc3VwcG9ydGVkIG9uIGFsbCBhcmNoaXRlY3R1cmVzCj4g
Cj4gU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPgo+IFJldmlld2Vk
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZWdhcmRpbmcg
dGhlIGNsYWltIHRoYXQgdGhpcyB3b3VsZCB3b3JrIGZvciAzMi1iaXQgeDg2IGJ1aWxkczoKCm1h
a2UgQVJDSD1pMzg2IGFsbG1vZGNvbmZpZwptYWtlIEFSQ0g9aTM4NiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLm8KCnJlc3VsdHMgaW46CgogIC4uLgogIENDIFtNXSAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5vCmRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYzogSW4gZnVuY3Rpb24g4oCYYW1kZ3B1X21tX3Jy
ZWc2NOKAmToKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jOjI3OTo5
OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYcmVhZHHigJk7Cgpk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmM6IEluIGZ1bmN0aW9uIOKA
mGFtZGdwdV9tbV93cmVnNjTigJk6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYzoyOTg6MzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKA
mHdyaXRlceKAmQoKVGhpcyBpcyB3aXRoIG5leHQtMjAxOTA4MDguCgpHdWVudGVyCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
