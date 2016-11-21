From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/76] drm/amd/dal: add meta address to video address struct
Date: Mon, 21 Nov 2016 18:00:30 -0500
Message-ID: <20161121230136.5208-11-harry.wentland@amd.com>
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
d190eXBlcy5oCmluZGV4IDEzYjQzZGQ2YjkyMS4uMjQ2MTEwMjAxYzEwIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2RhbC9kYy9kY19od190eXBlcy5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGFsL2RjL2RjX2h3X3R5cGVzLmgKQEAgLTc2LDYgKzc2LDggQEAgc3RydWN0IGRj
X3BsYW5lX2FkZHJlc3MgewogCiAJCS8qdmlkZW8gIHByb2dyZXNzaXZlKi8KIAkJc3RydWN0IHsK
KwkJCVBIWVNJQ0FMX0FERFJFU1NfTE9DIG1ldGFfY2hyb21hOworCQkJUEhZU0lDQUxfQUREUkVT
U19MT0MgbWV0YV9sdW1hOwogCQkJUEhZU0lDQUxfQUREUkVTU19MT0MgY2hyb21hX2FkZHI7CiAJ
CQlQSFlTSUNBTF9BRERSRVNTX0xPQyBsdW1hX2FkZHI7CiAJCX0gdmlkZW9fcHJvZ3Jlc3NpdmU7
Ci0tIAoyLjEwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
