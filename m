From: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 14/26] drm/amd/display: correct dcn21 NUM_VMID to 16
Date: Wed, 9 Oct 2019 17:06:01 -0400
Message-ID: <20191009210613.17929-15-Bhawanpreet.Lakha@amd.com>
References: <20191009210613.17929-1-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191009210613.17929-1-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
Cc: sunpeng.li-5C7GfCeVMHo@public.gmane.org, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, harry.wentland-5C7GfCeVMHo@public.gmane.org

RnJvbTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KCjEg
dm1pZCBsaW1pdGF0aW9uIG9ubHkgZXhpc3RzIGZvciBIT1NUVk0gd2hpY2ggaXMgYSBjdXN0b20K
dXNlIGNhc2UgYW55d2F5LgoKU2lnbmVkLW9mZi1ieTogRG15dHJvIExha3R5dXNoa2luIDxEbXl0
cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KQWNrZWQtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3
YW5wcmVldC5MYWtoYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY24yMS9kY24yMV9odWJidWIuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24yMS9kY24yMV9odWJidWIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMS9kY24yMV9odWJidWIuYwppbmRleCA0NGY2NGE4ZTMzZjEuLmFlYjVkZTZmNDUz
MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIx
X2h1YmJ1Yi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24y
MV9odWJidWIuYwpAQCAtNTIsNyArNTIsNyBAQAogI2lmZGVmIE5VTV9WTUlECiAjdW5kZWYgTlVN
X1ZNSUQKICNlbmRpZgotI2RlZmluZSBOVU1fVk1JRCAxCisjZGVmaW5lIE5VTV9WTUlEIDE2CiAK
IHN0YXRpYyB1aW50MzJfdCBjb252ZXJ0X2FuZF9jbGFtcCgKIAl1aW50MzJfdCB3bV9ucywKLS0g
CjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
