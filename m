From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 3/4] Call ValidateGC after ChangeClip in
 radeon_sync_scanout_pixmaps
Date: Tue, 29 Nov 2016 18:36:07 +0900
Message-ID: <20161129093608.27260-3-michel@daenzer.net>
References: <20161129093608.27260-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161129093608.27260-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGUgd3Jvbmcg
b3JkZXIgbWVhbnQgdGhhdCB0aGUgY2xpcHBpbmcgcmVnaW9uIHdhc24ndCBhY3R1YWxseSBhcHBs
aWVkLApzbyBpdCBhbHdheXMgY29waWVkIHRoZSBmdWxsIGNvbnRlbnRzIGZyb20gdGhlIG90aGVy
IHNjYW5vdXQgcGl4bWFwLgoKU2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5k
YWVuemVyQGFtZC5jb20+Ci0tLQogc3JjL3JhZGVvbl9rbXMuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NyYy9yYWRl
b25fa21zLmMgYi9zcmMvcmFkZW9uX2ttcy5jCmluZGV4IDhiYjI2MWUuLjU3NjRjMjAgMTAwNjQ0
Ci0tLSBhL3NyYy9yYWRlb25fa21zLmMKKysrIGIvc3JjL3JhZGVvbl9rbXMuYwpAQCAtNDk1LDgg
KzQ5NSw4IEBAIHJhZGVvbl9zeW5jX3NjYW5vdXRfcGl4bWFwcyh4Zjg2Q3J0Y1B0ciB4Zjg2X2Ny
dGMsIFJlZ2lvblB0ciBuZXdfcmVnaW9uLAogCiAgICAgZ2MgPSBHZXRTY3JhdGNoR0MoZHN0LT5k
ZXB0aCwgcFNjcmVlbik7CiAgICAgaWYgKGdjKSB7Ci0JVmFsaWRhdGVHQyhkc3QsIGdjKTsKIAln
Yy0+ZnVuY3MtPkNoYW5nZUNsaXAoZ2MsIENUX1JFR0lPTiwgc3luY19yZWdpb24sIDApOworCVZh
bGlkYXRlR0MoZHN0LCBnYyk7CiAJc3luY19yZWdpb24gPSBOVUxMOwogCWdjLT5vcHMtPkNvcHlB
cmVhKHNyYywgZHN0LCBnYywgMCwgMCwgZHN0LT53aWR0aCwgZHN0LT5oZWlnaHQsIDAsIDApOwog
CUZyZWVTY3JhdGNoR0MoZ2MpOwotLSAKMi4xMC4yCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
