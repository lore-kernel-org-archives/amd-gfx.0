From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 09/76] drm/amd/dal: add chroma support to
 program_size_and_rotation
Date: Mon, 21 Nov 2016 18:00:29 -0500
Message-ID: <20161121230136.5208-10-harry.wentland@amd.com>
References: <20161121230136.5208-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161121230136.5208-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>

RnJvbTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KClNp
Z25lZC1vZmYtYnk6IERteXRybyBMYWt0eXVzaGtpbiA8RG15dHJvLkxha3R5dXNoa2luQGFtZC5j
b20+CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY19od190eXBlcy5oIHwgMiArKwogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGFsL2RjL2RjX2h3X3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY19o
d190eXBlcy5oCmluZGV4IDBhNjUxMGQyYWQ5Ni4uMTNiNDNkZDZiOTIxIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY19od190eXBlcy5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGFsL2RjL2RjX2h3X3R5cGVzLmgKQEAgLTExNCw2ICsxMTQsNyBAQCB1bmlvbiBw
bGFuZV9zaXplIHsKIAkJICogMzIgcGl4ZWwgYWxpZ25lZC4KIAkJICovCiAJCXVpbnQzMl90IGx1
bWFfcGl0Y2g7CisJCXVpbnQzMl90IG1ldGFfbHVtYV9waXRjaDsKIAogCQlzdHJ1Y3QgcmVjdCBj
aHJvbWFfc2l6ZTsKIAkJLyogR3JhcGhpYyBzdXJmYWNlIHBpdGNoIGluIHBpeGVscy4KQEAgLTEy
MSw2ICsxMjIsNyBAQCB1bmlvbiBwbGFuZV9zaXplIHsKIAkJICogMzIgcGl4ZWwgYWxpZ25lZC4K
IAkJICovCiAJCXVpbnQzMl90IGNocm9tYV9waXRjaDsKKwkJdWludDMyX3QgbWV0YV9jaHJvbWFf
cGl0Y2g7CiAJfSB2aWRlbzsKIH07CiAKLS0gCjIuMTAuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
