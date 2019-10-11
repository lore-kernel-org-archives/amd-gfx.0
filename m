From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 19/19] ALSA: hda/hdmi - enable automatic runtime pm for AMD
 HDMI codecs by default
Date: Thu, 10 Oct 2019 20:45:36 -0500
Message-ID: <20191011014536.10869-20-alexander.deucher@amd.com>
References: <20191011014536.10869-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191011014536.10869-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

U28gdGhhdCB3ZSBjYW4gcG93ZXIgZG93biB0aGUgR1BVIGFuZCBhdWRpbyB0byBzYXZlIHBvd2Vy
LgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfaGRtaS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWkuYyBi
L3NvdW5kL3BjaS9oZGEvcGF0Y2hfaGRtaS5jCmluZGV4IGJlYTdiMDk2MTA4MC4uMjY2MTM3MzNm
MTA5IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX2hkbWkuYworKysgYi9zb3VuZC9w
Y2kvaGRhL3BhdGNoX2hkbWkuYwpAQCAtMzc3OSw2ICszNzc5LDcgQEAgc3RhdGljIGludCBhdGlo
ZG1pX2luaXQoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJCQkJCSAgICBBVElfVkVSQl9TRVRf
TVVMVElDSEFOTkVMX01PREUsCiAJCQkJCSAgICBBVElfTVVMVElDSEFOTkVMX01PREVfU0lOR0xF
KTsKIAl9CisJY29kZWMtPmF1dG9fcnVudGltZV9wbSA9IDE7CiAKIAlyZXR1cm4gMDsKIH0KLS0g
CjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
